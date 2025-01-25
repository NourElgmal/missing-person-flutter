import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:missing/Pages/login.dart';
import 'package:missing/Pages/pinpage.dart';
import 'package:missing/bloc/cubit.dart';
import 'package:missing/generated/l10n.dart';
import 'package:missing/widget/helpwidget.dart';
import 'package:http/http.dart' as http;
import 'package:missing/widget/url.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Sinup extends StatefulWidget {
  @override
  State<Sinup> createState() => _SinupState();
}

class _SinupState extends State<Sinup> {
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController confirm;
  bool isPasswordVisible = false;
  bool isconfirmVisible = false;
  FocusNode focus_email = FocusNode();
  FocusNode focus_pass = FocusNode();
  FocusNode focus_name = FocusNode();
  FocusNode focus_phone = FocusNode();
  FocusNode focus_confirm = FocusNode();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    pass = TextEditingController();
    name = TextEditingController();
    phone = TextEditingController();
    confirm = TextEditingController();
    focus_email.addListener(() {
      setState(() {});
    });
    focus_pass.addListener(() {
      setState(() {});
    });
    focus_name.addListener(() {
      setState(() {});
    });
    focus_phone.addListener(() {
      setState(() {});
    });
    focus_confirm.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    name.dispose();
    phone.dispose();
    confirm.dispose();
    focus_email.dispose();
    focus_pass.dispose();
    focus_name.dispose();
    focus_confirm.dispose();
    focus_phone.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (name.text.isEmpty ||
        phone.text.isEmpty ||
        email.text.isEmpty ||
        pass.text.isEmpty ||
        confirm.text.isEmpty) {
      _showErrorDialog(S.of(context).AllFieldsRequired);
      return;
    }

    if (pass.text.length < 8) {
      _showErrorDialog(S.of(context).PasswordLengthError);
      return;
    }

    if (pass.text != confirm.text) {
      _showErrorDialog(S.of(context).Passwords_Match);
      return;
    }

    _signUp();
  }

  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      btnOkText: S.of(context).Ok,
      btnCancelText: S.of(context).Cancel,
      title: S.of(context).Error,
      desc: message,
      btnOkOnPress: () {},
    )..show();
  }

  Future<void> _signUp() async {
    try {
      final res = await http.post(
        Uri.parse(Url.serverlink + Url.sinuplink),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "name": name.text,
          "phone": phone.text,
          "email": email.text,
          "password": pass.text,
          "confirm_password": confirm.text,
        }),
      );

      if (res.statusCode == 201) {
        final js = jsonDecode(res.body);
        String message = js["message"];
        log(message);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => VerifyScreen()),
          (route) => false,
        );
      } else {
        final js = jsonDecode(res.body);
        String message = js["message"];
        log(message);
        if (message == "User with this email already exists and not verified") {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              headerAnimationLoop: true,
              animType: AnimType.bottomSlide,
              btnOkText: S.of(context).Ok,
              btnCancelText: S.of(context).Cancel,
              title: S.of(context).Error,
              desc: message + S.of(context).go_verfied,
              btnOkOnPress: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => VerifyScreen()),
                  (route) => false,
                );
              },
              btnCancelOnPress: () {})
            ..show();
        } else {
          _showErrorDialog(message);
        }
      }
    } catch (e) {
      _showErrorDialog(S.of(context).Signup_Failed);
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    MyCubit cubit = MyCubit.get(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: screenHeight * .04,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    S.of(context).SignUp,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: screenHeight * 0.05,
                      fontFamily: "Lexend",
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                CustomInputFields.buildTextField(context,
                    focus: focus_name,
                    controller: name,
                    hint: S.of(context).name,
                    keyboardType: TextInputType.text),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.buildTextField(context,
                    focus: focus_phone,
                    controller: phone,
                    hint: S.of(context).Phone,
                    keyboardType: TextInputType.number),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.buildTextField(context,
                    focus: focus_email,
                    controller: email,
                    hint: S.of(context).Email,
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.buildPasswordField(context,
                    focus: focus_pass,
                    controller: pass,
                    hint: S.of(context).Password,
                    isPasswordVisible: isPasswordVisible,
                    onVisibilityToggle: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                }),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.buildPasswordField(context,
                    focus: focus_confirm,
                    controller: confirm,
                    hint: S.of(context).Confirm,
                    isPasswordVisible: isconfirmVisible,
                    onVisibilityToggle: () {
                  setState(() {
                    isconfirmVisible = !isconfirmVisible;
                  });
                }),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.ButtonSin(context,
                    name: S.of(context).SignUp,
                    color: Color.fromARGB(200, 17, 186, 17),
                    onVisibilityToggle: () {
                  cubit.changeEmail(email.text);
                  _validateAndSubmit();
                }),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        S.of(context).AlreadyAccount,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: FittedBox(
                        child: Text(
                          S.of(context).SignIn,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: screenHeight * 0.03,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
