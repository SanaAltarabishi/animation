import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CounterPage extends HookWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useCounterHook();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Custom Hook Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter: ${counter.counter}'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: counter.increment,
              child: const Text('Increment'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: counter.reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterHook extends Hook<_CounterHookState> {
  const CounterHook();

  @override
  _CounterHookState createState() => _CounterHookState();
}

class _CounterHookState extends HookState<_CounterHookState, CounterHook> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void reset() {
    setState(() {
      counter = 0;
    });
  }

  @override
  _CounterHookState build(BuildContext context) => this;

  @override
  void dispose() {
    // أي عمليات تنظيف إذا لزم الأمر
    super.dispose();
  }
}

_CounterHookState useCounterHook() {
  return use(const CounterHook());
}
