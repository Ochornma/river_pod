import 'package:flutter/material.dart';

import 'counter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Counter Page'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) =>
                    //for stream uncomment this and comment the other
                    // CounterStreamPage()
                    //for normal riverpod us this
                    const CounterPage()),
              ),
            );
          },
        ),
      ),
    );
  }
}
