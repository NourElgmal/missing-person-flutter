import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_state.dart';

class MyCubit extends Cubit<BlocState> {
  MyCubit() : super(ChangeLanguage()) {}

  String language = "ar";
  String groupValue = "";
  String foundOrMissing = "Found";
  String email = "";
  String token = "";
  String when_find_missing = "";
  String where_found_missing = "";
  Future<void> changeLanguage(String newLanguage) async {
    language = newLanguage;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLanguage);
    emit(ChangeLanguage());
  }

  void changeWhenFindMissing(String newWhen) {
    when_find_missing = newWhen;
    emit(When_Find_Missing());
  }

  void changeWhereFindMissing(String newWhere) {
    where_found_missing = newWhere;
    emit(Where_Find_Missing());
  }

  void changeEmail(String newEmail) {
    email = newEmail;
    emit(Email());
  }

  void SetToken(String Token) {
    token = Token;
    emit(Settoken());
  }

  void logout() {
    token = "";
    email = "";
    emit(Logout());
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    language = prefs.getString('language') ?? "ar";
    print(prefs.getString('language'));
    emit(GetLanguage());
  }

  void changeFoundMissing(String text) {
    foundOrMissing = text;
    emit(Found_or_missing());
  }

  void changeGroupValue(String value) {
    groupValue = value;
    emit(Group());
  }

  static MyCubit get(BuildContext context) {
    return BlocProvider.of<MyCubit>(context);
  }
}
