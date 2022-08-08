import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

// ConsumerWidget is like a StatelessWidget
// but with a WidgetRef parameter added in the build method.
class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using the WidgetRef to get the counter int from the counterProvider.
    // The watch method makes the widget rebuild whenever the int changes value.
    //   - something like setState() but automatic
    final int counter = ref.watch(counterProvider);

    ref.listen<int>(
      counterProvider,
      // "next" is referring to the new state.
      // The "previous" state is sometimes useful for logic in the callback.
      (previous, next) {
        if (next >= 5) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Warning'),
                content:
                    Text('Counter dangerously high. Consider resetting it.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  )
                ],
              );
            },
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          IconButton(
            onPressed: () {
              //this now maually disposses the provider
              ref.invalidate(counterProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Text(
          counter.toString(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Using the WidgetRef to read() the counterProvider just one time.
          //   - unlike watch(), this will never rebuild the widget automatically
          // We don't want to get the int but the actual StateNotifier, hence we access it.
          // StateNotifier exposes the int which we can then mutate (in our case increment).
          ref.read(counterProvider.notifier).state++;
        },
      ),
    );
  }
}
