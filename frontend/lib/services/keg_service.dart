import 'package:flutter/material.dart';
import 'package:frontend/models/keg_model.dart';
import 'package:frontend/services/pocketbase.dart';
import 'package:frontend/services/secure_storage_service.dart';
import 'package:pocketbase/pocketbase.dart';

enum KegStatus { loading, idle, error }

class KegService extends ChangeNotifier {
  final pbClient = Pocketbase().client;
  final storage = SecureStorageService().storage;

  KegStatus? _status;
  KegStatus? get status => _status;

  List<Keg> _kegs = [];
  List<Keg> get kegs => _kegs;

  KegService() {
    getKegs();
  }

  void getKegs() async {
    _status = KegStatus.loading;
    notifyListeners();
    final String? jwt = await storage?.read(key: 'token');
    if (jwt != null) {
      try {
        await pbClient.records
            .getList(
              'kegs',
              page: 1,
              perPage: 100,
              headers: {'Authorization': 'User $jwt'},
            )
            .then(
              (response) =>
                  response.items.map((item) => item.toJson()).toList(),
            )
            .then(
              (kegList) => {
                _kegs = kegList.map((keg) => Keg.fromJson(keg)).toList(),
              },
            );
        _status = KegStatus.idle;
        notifyListeners();
      } catch (e) {
        _status = KegStatus.error;
        notifyListeners();
        if (e is ClientException) {
          print(e.statusCode);
        }
      }
    }
  }
}
