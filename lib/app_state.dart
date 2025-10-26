import 'package:flutter/material.dart';
import 'models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    _secureStorage = const FlutterSecureStorage();

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

    // Cargar refresh token desde SecureStorage
    await _safeInitAsync(() async {
      _refreshToken = await _secureStorage.read(key: 'ff_refreshToken') ?? _refreshToken;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;
  late FlutterSecureStorage _secureStorage;

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
    prefs.setString('ff_token', value);
  }

  String _refreshToken = '';
  String get refreshToken => _refreshToken;
  set refreshToken(String value) {
    _refreshToken = value;
    _secureStorage.write(key: 'ff_refreshToken', value: value);
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

  List<CartItem> cartItems = [];
  double get cartTotal =>
      cartItems.fold(0, (sum, i) => sum + (i.price * i.quantity));

  void addToCart(CartItem item) {
    final idx = cartItems.indexWhere((i) => i.id == item.id);
    if (idx == -1) {
      cartItems.add(item);
    } else {
      cartItems[idx] =
          cartItems[idx].copyWith(quantity: cartItems[idx].quantity + item.quantity);
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    cartItems.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    final idx = cartItems.indexWhere((i) => i.id == id);
    if (idx != -1) {
      cartItems[idx] = cartItems[idx].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  // Limpiar tokens en logout
  Future<void> clearTokens() async {
    _token = '';
    _refreshToken = '';
    _userSessionID = 0;
    _userEmail = '';

    await prefs.remove('ff_token');
    await prefs.remove('ff_userSessionID');
    await prefs.remove('ff_userEmail');
    await _secureStorage.delete(key: 'ff_refreshToken');

    notifyListeners();
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
