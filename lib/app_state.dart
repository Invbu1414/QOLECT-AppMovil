import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _token = prefs.getString('ff_token') ?? _token;
    });
    _safeInit(() {
      _userSessionID = prefs.getInt('ff_userSessionID') ?? _userSessionID;
    });
    _safeInit(() {
      _userEmail = prefs.getString('ff_userEmail') ?? _userEmail;
    });
    _safeInit(() {
      _secondTimeOpen = prefs.getBool('ff_secondTimeOpen') ?? _secondTimeOpen;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
    prefs.setString('ff_token', value);
  }

  int _userSessionID = 0;
  int get userSessionID => _userSessionID;
  set userSessionID(int value) {
    _userSessionID = value;
    prefs.setInt('ff_userSessionID', value);
  }

  String _userEmail = '';
  String get userEmail => _userEmail;
  set userEmail(String value) {
    _userEmail = value;
    prefs.setString('ff_userEmail', value);
  }

  bool _secondTimeOpen = false;
  bool get secondTimeOpen => _secondTimeOpen;
  set secondTimeOpen(bool value) {
    _secondTimeOpen = value;
    prefs.setBool('ff_secondTimeOpen', value);
  }

  bool _isActionComplete = false;
  bool get isActionComplete => _isActionComplete;
  set isActionComplete(bool value) {
    _isActionComplete = value;
  }

  int _notificationsAmount = 0;
  int get notificationsAmount => _notificationsAmount;
  set notificationsAmount(int value) {
    _notificationsAmount = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
