import 'package:pocketbase/pocketbase.dart';

class Pocketbase {
  PocketBase? _client;
  PocketBase get client => _client ?? PocketBase('http://localhost:8090');
}
