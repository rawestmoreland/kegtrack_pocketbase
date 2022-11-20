import 'package:flutter/material.dart';
import 'package:frontend/services/keg_service.dart';
import 'package:frontend/services/pocketbase.dart';
import 'package:frontend/services/secure_storage_service.dart';
import 'package:pocketbase/pocketbase.dart';

enum LoginStatus { loading, idle, loggedIn, error }

class AuthService extends ChangeNotifier {
  final pbClient = Pocketbase().client;
  final storage = SecureStorageService().storage;
  final kegService = KegService();

  LoginStatus _status = LoginStatus.idle;
  LoginStatus get status => _status;

  String _token = "";
  String get token => _token;

  Future<void> login(String email, String password) async {
    _status = LoginStatus.loading;
    notifyListeners();
    try {
      final authData = await pbClient.users.authViaEmail(email, password);
      storage?.write(key: 'token', value: authData.token);
      _status = LoginStatus.loggedIn;
    } catch (e) {
      if (e is ClientException) {
        print(e.response['message']);
      }
      _status = LoginStatus.error;
    }
    notifyListeners();
  }

  logout() async {
    _status = LoginStatus.loading;
    notifyListeners();
    await storage?.delete(key: 'token');
    _status = LoginStatus.idle;
    notifyListeners();
  }

  Future getSavedToken() async {
    _token = (await storage?.read(key: "token")) ?? '';
    if (_token.isNotEmpty) {
      kegService.getKegs();
      _status = LoginStatus.loggedIn;
    } else {
      _status = LoginStatus.idle;
    }
    notifyListeners();
  }
}
