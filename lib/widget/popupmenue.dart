import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:missing/Pages/changepass.dart';
import 'package:missing/Pages/gosin_in_up.dart';
import 'package:missing/Pages/myuploads.dart';
import 'package:missing/Pages/updateprofile.dart';
import 'package:missing/bloc/cubit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:missing/generated/l10n.dart';
import 'package:missing/widget/url.dart';

class PopupMenu {
  Future<void> sendCode(String email, BuildContext context) async {
    try {
      final res = await http.post(
        Uri.parse(Url.serverlink + Url.forgotpasswordlink),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> message = jsonDecode(res.body);
        log("Message: ${message["message"]}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Changepass(),
          ),
        );
      } else {
        Map<String, dynamic> error = jsonDecode(res.body);
        log("Error: ${error["message"]}");
        _showErrorDialog(context, error["message"]);
      }
    } catch (e) {
      log("Exception: $e");
      _showErrorDialog(context, "Something went wrong. Please try again.");
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      final res = await http.delete(
        Uri.parse(Url.serverlink + Url.deleteaccountlink),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'token': '${MyCubit.get(context).token}',
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> message = jsonDecode(res.body);
        log("Message: ${message["message"]}");
        MyCubit.get(context).logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Gosin_In_Up(),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        Map<String, dynamic> error = jsonDecode(res.body);
        log("Error: ${error["message"]}");
        _showErrorDialog(context, error["message"]);
      }
    } catch (e) {
      log("Exception: $e");
      _showErrorDialog(
          context, "Unable to delete account. Please try again later.");
    }
  }

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: title,
      desc: content,
      btnOkText: S.of(context).Ok,
      btnCancelText: S.of(context).Cancel,
      btnCancelOnPress: () {},
      btnOkOnPress: onConfirm,
    ).show();
  }

  void _showErrorDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: "Error",
      btnOkText: S.of(context).Ok,
      btnCancelText: S.of(context).Cancel,
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  static Widget getPopupMenuButton(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) async {
        if (value == "language") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: S.of(context).SelectLanguage,
            btnCancelText: S.of(context).Arabic,
            btnOkText: S.of(context).English,
            btnCancelOnPress: () {
              MyCubit.get(context).changeLanguage('ar');
            },
            btnOkOnPress: () {
              MyCubit.get(context).changeLanguage('en');
            },
          ).show();
        } else if (value == "update") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateProfile(),
            ),
          );
        } else if (value == "my") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Myuploads(),
            ),
          );
        } else if (value == "password") {
          final email = MyCubit.get(context).email;
          if (email != null && email.isNotEmpty) {
            PopupMenu().sendCode(email, context);
          } else {
            PopupMenu()._showErrorDialog(
              context,
              S.of(context).EmailNotSet,
            );
          }
        } else if (value == "delete") {
          PopupMenu()._showConfirmationDialog(
            context,
            S.of(context).DeleteAccount,
            S.of(context).DeleteAccountConfirmation,
            () => PopupMenu().deleteAccount(context),
          );
        } else if (value == "logout") {
          PopupMenu()._showConfirmationDialog(
            context,
            S.of(context).Logout,
            S.of(context).LogoutConfirmation,
            () {
              MyCubit.get(context).logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Gosin_In_Up(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          );
        }
      },
      color: const Color.fromARGB(255, 235, 166, 247),
      icon: const Icon(
        Icons.list,
        color: Color.fromARGB(255, 166, 75, 182),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text(S.of(context).MyUploads),
          value: "my",
        ),
        PopupMenuItem(
          child: Text(S.of(context).UpdateProfile),
          value: "update",
        ),
        PopupMenuItem(
          child: Text(S.of(context).ChangeLanguage),
          value: "language",
        ),
        PopupMenuItem(
          child: Text(S.of(context).ChangePassword),
          value: "password",
        ),
        PopupMenuItem(
          child: Text(S.of(context).DeleteAccount),
          value: "delete",
        ),
        PopupMenuItem(
          child: Text(S.of(context).Logout),
          value: "logout",
        ),
      ],
    );
  }
}
