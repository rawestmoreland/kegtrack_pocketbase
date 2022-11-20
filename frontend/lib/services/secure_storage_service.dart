import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  FlutterSecureStorage? _storage;
  FlutterSecureStorage? get storage => _storage ?? const FlutterSecureStorage();
}
