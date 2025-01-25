import 'dart:convert';
import 'dart:developer';
import 'package:missing/bloc/cubit.dart';
import 'package:missing/generated/l10n.dart';
import 'package:missing/widget/helpwidget.dart';
import 'package:flutter/material.dart';
import 'package:missing/Pages/login.dart';
import 'package:missing/widget/url.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

class Changepass extends StatefulWidget {
  @override
  State<Changepass> createState() => _ChangepassState();
}

class _ChangepassState extends State<Changepass> {
  late TextEditingController _pinCodeController;
  late TextEditingController pass;
  bool isPasswordVisible = false;
  FocusNode focus_pass = FocusNode();
  @override
  void initState() {
    super.initState();
    _pinCodeController = TextEditingController();
    pass = TextEditingController();
    focus_pass.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    pass.dispose();
    focus_pass.dispose();
    super.dispose();
  }

  void _validateAndSubmit(String email) {
    if (_pinCodeController.text.isEmpty || pass.text.isEmpty) {
      _showErrorDialog(S.of(context).AllFieldsRequired, S.of(context).Error);
      return;
    }

    if (pass.text.length < 8) {
      _showErrorDialog(S.of(context).passlength, S.of(context).Error);
      return;
    }

    changepass(email);
  }

  void _showErrorDialog(String message, String title) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      title: title,
      btnOkText: S.of(context).Ok,
      btnCancelText: S.of(context).Cancel,
      desc: message,
      btnOkOnPress: () {},
    )..show();
  }

  Future<void> changepass(String email) async {
    String code = _pinCodeController.text;
    print(code);
    if (code.length == 5) {
      final res = await http.post(Uri.parse(Url.serverlink + Url.changpasslink),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(<String, String>{
            "email": email,
            "code": code,
            "new_pass": pass.text
          }));
      if (res.statusCode == 200) {
        Map<String, dynamic> js = jsonDecode(res.body);
        String message = js["message"];
        log(message);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
          (route) => false,
        );
      } else {
        Map<String, dynamic> js = jsonDecode(res.body);
        String message = js["message"];
        log(message);
        _showErrorDialog(message, S.of(context).Error);
      }
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: Text(S.of(context).Error),
            content: Text(S.of(context).complet_the_code),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).Ok)),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MyCubit cubit = MyCubit.get(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).AccountCreatedMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  S.of(context).ConfirmationEmailSent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                PinCodeTextField(
                  controller: _pinCodeController,
                  appContext: context,
                  length: 5,
                  onChanged: (value) {},
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: screenHeight * 0.08,
                    fieldWidth: screenWidth * 0.10,
                    activeColor: Theme.of(context).colorScheme.primary,
                    selectedColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                  cursorColor: Theme.of(context).colorScheme.primary,
                  textStyle: TextStyle(
                    fontSize: screenHeight * 0.03,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.buildPasswordField(
                  context,
                  controller: pass,
                  focus: focus_pass,
                  hint: S.of(context).Password,
                  isPasswordVisible: isPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                SizedBox(height: screenHeight * 0.04),
                InkWell(
                  onTap: () {
                    print(cubit.email);
                    _validateAndSubmit(cubit.email);
                  },
                  child: Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.06,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff1EA6D6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      S.of(context).Verify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  S.of(context).DidNotReceiveCode,
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.black54,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Action to resend code
                  },
                  child: Text(
                    S.of(context).complet_the_code,
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
