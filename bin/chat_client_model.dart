import 'dart:io';

import 'dart:typed_data';

class ChatClient {
  final Socket _socket;
  final String _address;
  final int _port;

  ChatClient(Socket s)
      : _socket = s,
        _address = s.remoteAddress.address,
        _port = s.remotePort {
    _socket.listen(
      messageHandeler,
      onDone: finishedHandeler,
      onError: errorHandeler,
    );
  }

  void messageHandeler(Uint8List data) {
    final message = String.fromCharCodes(data);
    distributeMessage(this, '$_address:$_port Message: $message');
  }

  void finishedHandeler() {
    print('$_address:$_port Disconnected');
    removeClinet(this);
    _socket.close();
  }

  void errorHandeler(error) {
    print('$_address:$_port Error: $error');
    removeClinet(this);
    _socket.close();
  }

  void write(String message) {
    _socket.write(message);
  }
}

List<ChatClient> clients = [];

void distributeMessage(ChatClient client, String message) {
  for (var c in clients) {
    if (c != client) {
      c.write(message);
    }
  }
}

void removeClinet(ChatClient client) {
  clients.remove(client);
}
