import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Example2 extends HookWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    final future = useMemoized(
        () =>
            Future.delayed(const Duration(seconds: 2), () => counter.value * 2),
        [counter.value]);

    final snap = useFuture(future);

    final stream = useMemoized(
        () => Stream.periodic(
            const Duration(seconds: 1), (data) => counter.value + data),
        [counter.value]);

    final streamValue = useStream(stream);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Text('${snap.data} ${snap.connectionState} '),
          const SizedBox(
            height: 50,
          ),
          Text('${streamValue.data} ${streamValue.connectionState} '),
          const SizedBox(
            height: 50,
          ),
          TextButton(
            child: Text('add state ${counter.value}'),
            onPressed: () {
              counter.value++;
            },
          ),
          const SizedBox(
            height: 50,
          ),
          TextButton(
            child: Text('-- state ${counter.value}'),
            onPressed: () {
              counter.value--;
            },
          ),

        ],
      ),
    );
  }
}
