import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

// ConsumerWidget is like a StatelessWidget
// but with a WidgetRef parameter added in the build method.
class CounterStreamPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue is a union of 3 cases - data, error and loading
    final AsyncValue<int> counter = ref.watch(counterStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Text(
          counter
              .when(
                //the value from the result
                data: (int value) => value,
                //the error to show
                error: (Object e, _) => e,
                // While we're waiting for the first counter value to arrive
                // we want the text to display zero.
                loading: () => 0,
              )
              .toString(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
