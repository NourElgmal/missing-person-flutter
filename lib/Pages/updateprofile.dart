import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:missing/Pages/home.dart';
import 'package:missing/bloc/cubit.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:missing/generated/l10n.dart';
import 'package:missing/widget/helpwidget.dart';
import 'package:missing/widget/url.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late TextEditingController email;
  late TextEditingController name;
  late TextEditingController phone;
  FocusNode focusName = FocusNode();
  FocusNode focusPhone = FocusNode();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    name = TextEditingController();
    phone = TextEditingController();
    focusName.addListener(() {
      setState(() {});
    });
    focusPhone.addListener(() {
      setState(() {});
    });
    getProfile();
  }

  @override
  void dispose() {
    email.dispose();
    name.dispose();
    phone.dispose();
    focusName.dispose();
    focusPhone.dispose();
    super.dispose();
  }

  Future<void> getProfile() async {
    final url = Url.serverlink + Url.Grtaccountlink;
    final token = '${MyCubit.get(context).token}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "token": token,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Data = jsonDecode(response.body);
        final data = Data['user'];
        setState(() {
          email.text = data["email"] ?? "";
          name.text = data["name"] ?? "";
          phone.text = data["phone"] ?? "";
        });
        log(S.of(context).ProfileFetched);
      } else {
        final errorData = jsonDecode(response.body);
        log(S.of(context).ProfileFetchError + ": ${errorData["message"]}");
      }
    } catch (e) {
      log(S.of(context).ProfileFetchException + ": $e");
    }
  }

  void _validateAndSubmit() {
    if (name.text.isEmpty || phone.text.isEmpty) {
      _showErrorDialog(S.of(context).AllFieldsRequired, S.of(context).Error);
      return;
    }

    if (name.text.length < 3) {
      _showErrorDialog(S.of(context).NameTooShort, S.of(context).Error);
      return;
    }

    if (phone.text.length != 11) {
      _showErrorDialog(S.of(context).PhoneInvalidLength, S.of(context).Error);
      return;
    }

    _updateAccount();
  }

  Future<void> _updateAccount() async {
    final url = Url.serverlink + Url.Updateprofilelink;
    final token = '${MyCubit.get(context).token}';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "token": token,
        },
        body: jsonEncode({
          "name": name.text,
          "phone": phone.text,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        log(S.of(context).ProfileUpdateSuccess + ": ${data["message"]}");

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
        );
      } else {
        final errorData = jsonDecode(response.body);
        final message = errorData["message"] ?? S.of(context).UnknownError;
        log(S.of(context).ProfileUpdateError + ": $message");
        _showErrorDialog(message, S.of(context).Error);
      }
    } catch (e) {
      log(S.of(context).ProfileUpdateException + ": $e");
      _showErrorDialog(S.of(context).UpdateFailed, S.of(context).Error);
    }
  }

  void _showErrorDialog(String message, String title) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      btnOkOnPress: () {},
    ).show();
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
            color: Colors.black,
          ),
        ),
        title: Text(
          S.of(context).UpdateProfile,
          style: TextStyle(color: Colors.black),
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
                    S.of(context).UpdateYourProfile,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: screenHeight * 0.05,
                      fontFamily: "Lexend",
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                TextField(
                  controller: email,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: S.of(context).EmailAddress,
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: screenHeight * 0.04),
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.buildTextField(
                  context,
                  controller: name,
                  focus: focusName,
                  hint: S.of(context).FullName,
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.buildTextField(
                  context,
                  controller: phone,
                  focus: focusPhone,
                  hint: S.of(context).PhoneNumber,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomInputFields.ButtonSin(
                  context,
                  name: S.of(context).Update,
                  color: Color.fromARGB(200, 17, 186, 17),
                  onVisibilityToggle: _validateAndSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
