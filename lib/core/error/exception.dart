class ServerException implements Exception {
  String? errMsg;

  ServerException({this.errMsg});
}

class CacheException implements Exception {}

class AuthException implements Exception {}
