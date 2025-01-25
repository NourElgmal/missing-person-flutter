import 'package:flutter/material.dart';
import 'package:missing/Pages/login.dart';
import 'package:missing/Pages/sinup.dart';
import 'package:missing/bloc/cubit.dart';
import 'package:missing/generated/l10n.dart';
import 'package:missing/widget/helpwidget.dart';
import 'package:missing/widget/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gosin_In_Up extends StatelessWidget {
  void long(String s) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', s);
    print(prefs.getString('language'));
  }

  @override
  Widget build(BuildContext context) {
    MyCubit cubit = MyCubit.get(context);
    void _showLanguageDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return LanguageDialog(
            onSelect: (String language) {
              if (language == "English") {
                long('en');
                cubit.changeLanguage('en');
              } else {
                long('ar');
                cubit.changeLanguage('ar');
              }
            },
          );
        },
      );
    }

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network(
                Url.sin_in_up,
                height: screenHeight * 0.7,
              ),
              SizedBox(height: screenHeight * 0.03),
              CustomInputFields.ButtonSin(context,
                  name: S.of(context).SignUp,
                  color: Color.fromARGB(200, 17, 186, 17),
                  onVisibilityToggle: () {
                Navigator.of(context).push(DialogRoute(
                  context: context,
                  builder: (context) => Sinup(),
                ));
              }),
              SizedBox(height: screenHeight * 0.03),
              CustomInputFields.ButtonSin(context,
                  name: S.of(context).SignIn,
                  color: Color.fromARGB(200, 17, 186, 17),
                  onVisibilityToggle: () {
                Navigator.of(context).push(DialogRoute(
                  context: context,
                  builder: (context) => Login(),
                ));
              }),
              SizedBox(height: screenHeight * 0.02),
              TextButton(
                onPressed: _showLanguageDialog,
                child: Text(S.of(context).ChangeLanguage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageDialog extends StatelessWidget {
  final Function(String) onSelect;

  LanguageDialog({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).SelectLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              onSelect('English');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('العربية'),
            onTap: () {
              onSelect('Arabic');
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
