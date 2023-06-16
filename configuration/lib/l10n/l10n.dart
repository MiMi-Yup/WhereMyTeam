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

class MultiLanguage {
  MultiLanguage();

  static MultiLanguage? _current;

  static MultiLanguage get current {
    assert(_current != null,
        'No instance of MultiLanguage was loaded. Try to initialize the MultiLanguage delegate before accessing MultiLanguage.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<MultiLanguage> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = MultiLanguage();
      MultiLanguage._current = instance;

      return instance;
    });
  }

  static MultiLanguage of(BuildContext context) {
    final instance = MultiLanguage.maybeOf(context);
    assert(instance != null,
        'No instance of MultiLanguage present in the widget tree. Did you add MultiLanguage.delegate in localizationsDelegates?');
    return instance!;
  }

  static MultiLanguage? maybeOf(BuildContext context) {
    return Localizations.of<MultiLanguage>(context, MultiLanguage);
  }

  /// `Database exception`
  String get databaseException {
    return Intl.message(
      'Database exception',
      name: 'databaseException',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Connect timeout`
  String get connectTimeout {
    return Intl.message(
      'Connect timeout',
      name: 'connectTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout`
  String get receiveTimeout {
    return Intl.message(
      'Receive timeout',
      name: 'receiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout`
  String get sendTimeout {
    return Intl.message(
      'Send timeout',
      name: 'sendTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Không có kết nối mạng`
  String get connectionProblem {
    return Intl.message(
      'Không có kết nối mạng',
      name: 'connectionProblem',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng kiểm tra lại tín hiệu Wifi hoặc 3G/4G của bạn.`
  String get connectionProblemDesc {
    return Intl.message(
      'Vui lòng kiểm tra lại tín hiệu Wifi hoặc 3G/4G của bạn.',
      name: 'connectionProblemDesc',
      desc: '',
      args: [],
    );
  }

  /// `Server not found`
  String get serverNotFound {
    return Intl.message(
      'Server not found',
      name: 'serverNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống có chút vấn đề`
  String get serverUnknownError {
    return Intl.message(
      'Hệ thống có chút vấn đề',
      name: 'serverUnknownError',
      desc: '',
      args: [],
    );
  }

  /// `Get setting`
  String get getSetting {
    return Intl.message(
      'Get setting',
      name: 'getSetting',
      desc: '',
      args: [],
    );
  }

  /// `Something wrong! Please try later.`
  String get systemError {
    return Intl.message(
      'Something wrong! Please try later.',
      name: 'systemError',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Try it`
  String get tryIt {
    return Intl.message(
      'Try it',
      name: 'tryIt',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `or continue with`
  String get otherLogin {
    return Intl.message(
      'or continue with',
      name: 'otherLogin',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Login to Your Account`
  String get loginTitle {
    return Intl.message(
      'Login to Your Account',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create Your Account`
  String get signUpTitle {
    return Intl.message(
      'Create Your Account',
      name: 'signUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get loginSuggest {
    return Intl.message(
      'Already have an account? ',
      name: 'loginSuggest',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get signUpSuggest {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'signUpSuggest',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberAccount {
    return Intl.message(
      'Remember me',
      name: 'rememberAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email or password is invalid`
  String get inValidInput {
    return Intl.message(
      'Email or password is invalid',
      name: 'inValidInput',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get languageName {
    return Intl.message(
      'English',
      name: 'languageName',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get darkTheme {
    return Intl.message(
      'Dark theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get helpCenter {
    return Intl.message(
      'Help Center',
      name: 'helpCenter',
      desc: '',
      args: [],
    );
  }

  /// `Team`
  String get teamPage {
    return Intl.message(
      'Team',
      name: 'teamPage',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get mapPage {
    return Intl.message(
      'Map',
      name: 'mapPage',
      desc: '',
      args: [],
    );
  }

  /// `Add Member`
  String get addMember {
    return Intl.message(
      'Add Member',
      name: 'addMember',
      desc: '',
      args: [],
    );
  }

  /// `Search person`
  String get searchPerson {
    return Intl.message(
      'Search person',
      name: 'searchPerson',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get notFound {
    return Intl.message(
      'Not Found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Missing something in form`
  String get missingSomething {
    return Intl.message(
      'Missing something in form',
      name: 'missingSomething',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed`
  String get loginFailed {
    return Intl.message(
      'Login Failed',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Route {name}`
  String routerName(String name) {
    return Intl.message(
      'Route $name',
      name: 'routerName',
      desc: 'Name of route',
      args: [name],
    );
  }

  /// `Hide`
  String get hide {
    return Intl.message(
      'Hide',
      name: 'hide',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `mins`
  String get mins {
    return Intl.message(
      'mins',
      name: 'mins',
      desc: '',
      args: [],
    );
  }

  /// `Top speed`
  String get topSpeed {
    return Intl.message(
      'Top speed',
      name: 'topSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance {
    return Intl.message(
      'Distance',
      name: 'distance',
      desc: '',
      args: [],
    );
  }

  /// `members`
  String get members {
    return Intl.message(
      'members',
      name: 'members',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get nickname {
    return Intl.message(
      'Nickname',
      name: 'nickname',
      desc: '',
      args: [],
    );
  }

  /// `Kick member`
  String get kickMember {
    return Intl.message(
      'Kick member',
      name: 'kickMember',
      desc: '',
      args: [],
    );
  }

  /// `Your teams`
  String get yourTeams {
    return Intl.message(
      'Your teams',
      name: 'yourTeams',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get family {
    return Intl.message(
      'Family',
      name: 'family',
      desc: '',
      args: [],
    );
  }

  /// `New team`
  String get newTeam {
    return Intl.message(
      'New team',
      name: 'newTeam',
      desc: '',
      args: [],
    );
  }

  /// `Name team`
  String get nameTeam {
    return Intl.message(
      'Name team',
      name: 'nameTeam',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get confirmLogout {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `Route`
  String get route {
    return Intl.message(
      'Route',
      name: 'route',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get empty {
    return Intl.message(
      'Empty',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get username {
    return Intl.message(
      'User name',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get goodMorning {
    return Intl.message(
      'Good Morning',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon`
  String get goodAfternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'goodAfternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get goodEvening {
    return Intl.message(
      'Good Evening',
      name: 'goodEvening',
      desc: '',
      args: [],
    );
  }

  /// `Good Night`
  String get goodNight {
    return Intl.message(
      'Good Night',
      name: 'goodNight',
      desc: '',
      args: [],
    );
  }

  /// `People Nearby`
  String get peopleNearby {
    return Intl.message(
      'People Nearby',
      name: 'peopleNearby',
      desc: '',
      args: [],
    );
  }

  /// `Your Family`
  String get yourFamily {
    return Intl.message(
      'Your Family',
      name: 'yourFamily',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Teams`
  String get teams {
    return Intl.message(
      'Teams',
      name: 'teams',
      desc: '',
      args: [],
    );
  }

  /// `No Teams`
  String get noTeams {
    return Intl.message(
      'No Teams',
      name: 'noTeams',
      desc: '',
      args: [],
    );
  }

  /// `Leave Team`
  String get leaveTeam {
    return Intl.message(
      'Leave Team',
      name: 'leaveTeam',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<MultiLanguage> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<MultiLanguage> load(Locale locale) => MultiLanguage.load(locale);
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
