import 'dart:developer';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  void initSocket() {
    log('Initializing socket connection...');
    _isConnected = true;
  }

  void emit(String event, dynamic data) {
    if (_isConnected) {
      log('Socket emitting event $event with data: $data');
    }
  }

  void disconnect() {
    log('Disconnecting socket...');
    _isConnected = false;
  }
}
