import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:missing/Pages/changepass.dart';
import 'package:missing/Pages/home.dart';
import 'package:missing/Pages/pinpage.dart';
import 'package:missing/Pages/sinup.dart';
import 'package:missing/bloc/cubit.dart';
import 'package:missing/generated/l10n.dart';
import 'package:missing/widget/helpwidget.dart';
import 'package:http/http.dart' as http;
import 'package:missing/widget/url.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController email;
  late TextEditingController pass;
  bool isPasswordVisible = false;
  FocusNode focus_email = FocusNode();
  FocusNode focus_pass = FocusNode();
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    pass = TextEditingController();
    focus_email.addListener(
      () {
        setState(() {});
      },
    );
    focus_pass.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    focus_email.dispose();
    focus_pass.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (email.text.isEmpty || pass.text.isEmpty) {
      _showErrorDialog(S.of(context).AllFieldsRequired, S.of(context).Error);
      return;
    }

    if (pass.text.length < 8) {
      _showErrorDialog(S.of(context).Passwords_Match, S.of(context).Error);
      return;
    }

    sinIn();
  }

  void _showErrorDialog(String message, String title) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      btnOkText: S.of(context).Ok,
      btnCancelText: S.of(context).Cancel,
      title: S.of(context).Error,
      desc: message,
      btnOkOnPress: () {},
    )..show();
  }

  Future<void> sinIn() async {
    try {
      final res = await http.post(
        Uri.parse(Url.serverlink + Url.loginlink),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "email": email.text,
          "password": pass.text,
        }),
      );

      if (res.statusCode == 201) {
        MyCubit.get(context).changeEmail(email.text);
        final js = jsonDecode(res.body);
        String message = js["message"];
        String token = js["token"];
        MyCubit.get(context).SetToken(token);
        log(message + "\n" + token);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
        );
      } else {
        final js = jsonDecode(res.body);
        String message = js["message"];
        log(message);
        if (message == "Account is not verified check your email") {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              headerAnimationLoop: true,
              animType: AnimType.bottomSlide,
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
          _showErrorDialog(message, S.of(context).Error);
        }
      }
    } catch (e) {
      _showErrorDialog(S.of(context).SignIn_Failed, S.of(context).Error);
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
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
                    S.of(context).SignIn,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: screenHeight * 0.05,
                      fontFamily: "Lexend",
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.buildTextField(context,
                    controller: email,
                    focus: focus_email,
                    hint: S.of(context).Email,
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.buildPasswordField(context,
                    controller: pass,
                    focus: focus_pass,
                    hint: S.of(context).Password,
                    isPasswordVisible: isPasswordVisible,
                    onVisibilityToggle: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                }),
                SizedBox(height: screenHeight * 0.02),
                InkWell(
                  onTap: () async {
                    MyCubit cubit = MyCubit.get(context);

                    if (!email.text.isEmpty) {
                      cubit.changeEmail(email.text);
                      final res = await http.post(
                        Uri.parse(Url.serverlink + Url.forgotpasswordlink),
                        headers: <String, String>{
                          "Content-Type": "application/json; charset=UTF-8",
                        },
                        body: jsonEncode(<String, String>{
                          "email": email.text,
                        }),
                      );
                      print(res.statusCode);
                      if (res.statusCode == 200) {
                        final js = jsonDecode(res.body);
                        String message = js["message"];
                        log(message);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => VerifyScreen()),
                          (route) => false,
                        );
                      } else {
                        _showErrorDialog(
                            S.of(context).err_emial, S.of(context).Error);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Changepass(),
                          ));
                    } else {
                      _showErrorDialog(
                          S.of(context).emial_req, S.of(context).Error);
                    }
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      child: Text(
                        S.of(context).forgotpass,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomInputFields.ButtonSin(context,
                    name: S.of(context).SignIn,
                    color: Color.fromARGB(200, 17, 186, 17),
                    onVisibilityToggle: () {
                  MyCubit cubit = MyCubit.get(context);
                  cubit.changeEmail(email.text);
                  _validateAndSubmit();
                }),
                SizedBox(height: screenHeight * 0.02),
                /*
                InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      color: Colors.white,
                    ),
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.08,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              Url.googleimg,
                              height: screenHeight * 0.05,
                              width: screenHeight * 0.05,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              S.of(context).login_google,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: screenHeight * 0.025,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        S.of(context).DontAccount,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(DialogRoute(
                          context: context,
                          builder: (context) => Sinup(),
                        ));
                      },
                      child: FittedBox(
                        child: Text(
                          S.of(context).SignUp,
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
