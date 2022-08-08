import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home.dart';

final counterProvider = StateProvider((ref) => 0);
//if you need the provider to dispose automatically use
//final counterProvider = StateProvider.autoDispose((ref) => 0);

//this is for demoing a websocket or api call
abstract class WebsocketClient {
  Stream<int> getCounterStream();
}

//this class assumes we are making an api call or websocket
class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream() async* {
    int i = 0;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      yield i++;
    }
  }
}

//the provider for the websocket
final websocketClientProvider = Provider<WebsocketClient>(
  (ref) {
    return FakeWebsocketClient();
  },
);

//the value from the the stream
final counterStreamProvider = StreamProvider<int>((ref) {
  final wsClient = ref.watch(websocketClientProvider);
  return wsClient.getCounterStream();
});

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      home: HomePage(),
    );
  }
}
