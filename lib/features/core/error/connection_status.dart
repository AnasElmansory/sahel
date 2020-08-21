import 'dart:io';

enum Connection { Connected, NotConnected }

// ignore: missing_return
Future<Connection> checkConnection() async {
  Connection _connectionStatus;
  final _result =
      await InternetAddress.lookup('google.com').catchError((onError) {
    _connectionStatus = Connection.NotConnected;
  });
  (_result != null && _result.isNotEmpty && _result[0].rawAddress.isNotEmpty)
      ? _connectionStatus = Connection.Connected
      : _connectionStatus = Connection.NotConnected;
  return _connectionStatus;
}
