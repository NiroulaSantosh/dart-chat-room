import 'dart:io';

import 'chat_client_model.dart';

late ServerSocket server;
void main(List<String> arguments) async {
  ServerSocket.bind(InternetAddress.anyIPv4, 4567).then((value) {
    server = value;

    server.listen(handleConnection);
  });
}

void handleConnection(Socket clinet) {
  print(
    'Connection form'
    '${clinet.remoteAddress.address}:${clinet.remotePort}',
  );

  clients.add(ChatClient(clinet));

  clinet.write('Welcome to chat room!'
      'There is ${clients.length - 1} other clients\n');
}
