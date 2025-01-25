// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message(
      'Sign In',
      name: 'SignIn',
      desc: '',
      args: [],
    );
  }

  /// `Email `
  String get Email {
    return Intl.message(
      'Email ',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `I forgot my password`
  String get forgotpass {
    return Intl.message(
      'I forgot my password',
      name: 'forgotpass',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an Account ?`
  String get DontAccount {
    return Intl.message(
      'Don\'t have an Account ?',
      name: 'DontAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message(
      'Sign Up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get name {
    return Intl.message(
      'Full name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get Confirm {
    return Intl.message(
      'Confirm Password',
      name: 'Confirm',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get Phone {
    return Intl.message(
      'Phone Number',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `Already have an Account ?`
  String get AlreadyAccount {
    return Intl.message(
      'Already have an Account ?',
      name: 'AlreadyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Missing Child`
  String get MissingChild {
    return Intl.message(
      'Missing Child',
      name: 'MissingChild',
      desc: '',
      args: [],
    );
  }

  /// `Found Child`
  String get FoundChild {
    return Intl.message(
      'Found Child',
      name: 'FoundChild',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Alerts`
  String get Alerts {
    return Intl.message(
      'Alerts',
      name: 'Alerts',
      desc: '',
      args: [],
    );
  }

  /// `No Match Found yet`
  String get NoMatch {
    return Intl.message(
      'No Match Found yet',
      name: 'NoMatch',
      desc: '',
      args: [],
    );
  }

  /// `Match Detected`
  String get Match {
    return Intl.message(
      'Match Detected',
      name: 'Match',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get Pending {
    return Intl.message(
      'Pending',
      name: 'Pending',
      desc: '',
      args: [],
    );
  }

  /// `Show Information`
  String get ShowInformation {
    return Intl.message(
      'Show Information',
      name: 'ShowInformation',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get SelectLanguage {
    return Intl.message(
      'Select Language',
      name: 'SelectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get ChangeLanguage {
    return Intl.message(
      'Change Language',
      name: 'ChangeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Enter Missing Child Information`
  String get missing {
    return Intl.message(
      'Enter Missing Child Information',
      name: 'missing',
      desc: '',
      args: [],
    );
  }

  /// `Enter Found Child Information`
  String get found {
    return Intl.message(
      'Enter Found Child Information',
      name: 'found',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Where Find him`
  String get where_find_him {
    return Intl.message(
      'Where Find him',
      name: 'where_find_him',
      desc: '',
      args: [],
    );
  }

  /// `When Find him`
  String get when_find_him {
    return Intl.message(
      'When Find him',
      name: 'when_find_him',
      desc: '',
      args: [],
    );
  }

  /// `Where Missing him`
  String get where_miss_him {
    return Intl.message(
      'Where Missing him',
      name: 'where_miss_him',
      desc: '',
      args: [],
    );
  }

  /// `When Missing him`
  String get when_miss_him {
    return Intl.message(
      'When Missing him',
      name: 'when_miss_him',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get Male {
    return Intl.message(
      'Male',
      name: 'Male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get Female {
    return Intl.message(
      'Female',
      name: 'Female',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get Enter {
    return Intl.message(
      'Enter',
      name: 'Enter',
      desc: '',
      args: [],
    );
  }

  /// `Child Information`
  String get Ch_Information {
    return Intl.message(
      'Child Information',
      name: 'Ch_Information',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get Upload_Photo {
    return Intl.message(
      'Upload Photo',
      name: 'Upload_Photo',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get login_google {
    return Intl.message(
      'Login with Google',
      name: 'login_google',
      desc: '',
      args: [],
    );
  }

  /// `found`
  String get foundOr {
    return Intl.message(
      'found',
      name: 'foundOr',
      desc: '',
      args: [],
    );
  }

  /// `Missing`
  String get Missingor {
    return Intl.message(
      'Missing',
      name: 'Missingor',
      desc: '',
      args: [],
    );
  }

  /// `...Sends`
  String get Uploading {
    return Intl.message(
      '...Sends',
      name: 'Uploading',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get Upload {
    return Intl.message(
      'Send',
      name: 'Upload',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get Info {
    return Intl.message(
      'Info',
      name: 'Info',
      desc: '',
      args: [],
    );
  }

  /// `No image selected.`
  String get NoImageSelected {
    return Intl.message(
      'No image selected.',
      name: 'NoImageSelected',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all the fields.`
  String get FillAllFields {
    return Intl.message(
      'Please fill all the fields.',
      name: 'FillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `The image was uploaded successfully and no match was found yet`
  String get notmatch {
    return Intl.message(
      'The image was uploaded successfully and no match was found yet',
      name: 'notmatch',
      desc: '',
      args: [],
    );
  }

  /// `Image upload failed`
  String get UploadFailed {
    return Intl.message(
      'Image upload failed',
      name: 'UploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Error while uploading`
  String get ErrorWhileUploading {
    return Intl.message(
      'Error while uploading',
      name: 'ErrorWhileUploading',
      desc: '',
      args: [],
    );
  }

  /// `Image deleted successfully`
  String get Image_deleted {
    return Intl.message(
      'Image deleted successfully',
      name: 'Image_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this post?`
  String get sure_delete_img {
    return Intl.message(
      'Are you sure you want to delete this post?',
      name: 'sure_delete_img',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get Ok {
    return Intl.message(
      'Ok',
      name: 'Ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `My uploads`
  String get MyUploads {
    return Intl.message(
      'My uploads',
      name: 'MyUploads',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get UpdateProfile {
    return Intl.message(
      'Update profile',
      name: 'UpdateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get ChangePassword {
    return Intl.message(
      'Change password',
      name: 'ChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get DeleteAccount {
    return Intl.message(
      'Delete account',
      name: 'DeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Email is not set. Please update your profile.`
  String get EmailNotSet {
    return Intl.message(
      'Email is not set. Please update your profile.',
      name: 'EmailNotSet',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This action cannot be undone.`
  String get DeleteAccountConfirmation {
    return Intl.message(
      'Are you sure you want to delete your account? This action cannot be undone.',
      name: 'DeleteAccountConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get LogoutConfirmation {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'LogoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Child Information`
  String get ChildInformation {
    return Intl.message(
      'Child Information',
      name: 'ChildInformation',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get Age {
    return Intl.message(
      'Age',
      name: 'Age',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get Gender {
    return Intl.message(
      'Gender',
      name: 'Gender',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get Status {
    return Intl.message(
      'Status',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// `Lost or Found`
  String get LostOrFound {
    return Intl.message(
      'Lost or Found',
      name: 'LostOrFound',
      desc: '',
      args: [],
    );
  }

  /// `Lost`
  String get Lost {
    return Intl.message(
      'Lost',
      name: 'Lost',
      desc: '',
      args: [],
    );
  }

  /// `Where found him`
  String get WhereFindHim {
    return Intl.message(
      'Where found him',
      name: 'WhereFindHim',
      desc: '',
      args: [],
    );
  }

  /// `When found him`
  String get WhenFindHim {
    return Intl.message(
      'When found him',
      name: 'WhenFindHim',
      desc: '',
      args: [],
    );
  }

  /// `Other Party Information (missing)`
  String get OtherPartyInformationMissing {
    return Intl.message(
      'Other Party Information (missing)',
      name: 'OtherPartyInformationMissing',
      desc: '',
      args: [],
    );
  }

  /// `Other Party Information (found)`
  String get OtherPartyInformationFound {
    return Intl.message(
      'Other Party Information (found)',
      name: 'OtherPartyInformationFound',
      desc: '',
      args: [],
    );
  }

  /// `Not found yet`
  String get NotFoundYet {
    return Intl.message(
      'Not found yet',
      name: 'NotFoundYet',
      desc: '',
      args: [],
    );
  }

  /// `Update Your Profile`
  String get UpdateYourProfile {
    return Intl.message(
      'Update Your Profile',
      name: 'UpdateYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get EmailAddress {
    return Intl.message(
      'Email Address',
      name: 'EmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get FullName {
    return Intl.message(
      'Full Name',
      name: 'FullName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `All fields are required.`
  String get AllFieldsRequired {
    return Intl.message(
      'All fields are required.',
      name: 'AllFieldsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 3 characters long.`
  String get NameTooShort {
    return Intl.message(
      'Name must be at least 3 characters long.',
      name: 'NameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be 11 digits.`
  String get PhoneInvalidLength {
    return Intl.message(
      'Phone number must be 11 digits.',
      name: 'PhoneInvalidLength',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get ProfileUpdateSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'ProfileUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error updating profile`
  String get ProfileUpdateError {
    return Intl.message(
      'Error updating profile',
      name: 'ProfileUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Profile fetched successfully`
  String get ProfileFetched {
    return Intl.message(
      'Profile fetched successfully',
      name: 'ProfileFetched',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching profile`
  String get ProfileFetchError {
    return Intl.message(
      'Error fetching profile',
      name: 'ProfileFetchError',
      desc: '',
      args: [],
    );
  }

  /// `Exception occurred while fetching profile`
  String get ProfileFetchException {
    return Intl.message(
      'Exception occurred while fetching profile',
      name: 'ProfileFetchException',
      desc: '',
      args: [],
    );
  }

  /// `Exception occurred while updating profile`
  String get ProfileUpdateException {
    return Intl.message(
      'Exception occurred while updating profile',
      name: 'ProfileUpdateException',
      desc: '',
      args: [],
    );
  }

  /// `Update failed`
  String get UpdateFailed {
    return Intl.message(
      'Update failed',
      name: 'UpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error occurred`
  String get UnknownError {
    return Intl.message(
      'Unknown error occurred',
      name: 'UnknownError',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get Update {
    return Intl.message(
      'Update',
      name: 'Update',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get Error {
    return Intl.message(
      'Error',
      name: 'Error',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for creating your account!`
  String get AccountCreatedMessage {
    return Intl.message(
      'Thank you for creating your account!',
      name: 'AccountCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `A confirmation email has been sent to your inbox.`
  String get ConfirmationEmailSent {
    return Intl.message(
      'A confirmation email has been sent to your inbox.',
      name: 'ConfirmationEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `VERIFY`
  String get Verify {
    return Intl.message(
      'VERIFY',
      name: 'Verify',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the code?`
  String get DidNotReceiveCode {
    return Intl.message(
      'Didn\'t receive the code?',
      name: 'DidNotReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `complet the code`
  String get complet_the_code {
    return Intl.message(
      'complet the code',
      name: 'complet_the_code',
      desc: '',
      args: [],
    );
  }

  /// `Password Length Error`
  String get passlength {
    return Intl.message(
      'Password Length Error',
      name: 'passlength',
      desc: '',
      args: [],
    );
  }

  /// `if you wont to go verfied page enter ok`
  String get go_verfied {
    return Intl.message(
      'if you wont to go verfied page enter ok',
      name: 'go_verfied',
      desc: '',
      args: [],
    );
  }

  /// `Passwords Do Not Match`
  String get Passwords_Match {
    return Intl.message(
      'Passwords Do Not Match',
      name: 'Passwords_Match',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long.`
  String get PasswordLengthError {
    return Intl.message(
      'Password must be at least 8 characters long.',
      name: 'PasswordLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Login failed. Make sure you are connected to the internet and try again.`
  String get SignIn_Failed {
    return Intl.message(
      'Login failed. Make sure you are connected to the internet and try again.',
      name: 'SignIn_Failed',
      desc: '',
      args: [],
    );
  }

  /// `Error in emial`
  String get err_emial {
    return Intl.message(
      'Error in emial',
      name: 'err_emial',
      desc: '',
      args: [],
    );
  }

  /// `Signup failed. Make sure you are connected to the internet and try again.`
  String get Signup_Failed {
    return Intl.message(
      'Signup failed. Make sure you are connected to the internet and try again.',
      name: 'Signup_Failed',
      desc: '',
      args: [],
    );
  }

  /// `Email is Required`
  String get emial_req {
    return Intl.message(
      'Email is Required',
      name: 'emial_req',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
