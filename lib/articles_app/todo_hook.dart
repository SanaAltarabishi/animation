import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class TodoPage extends HookWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkSet = useSetHook<int>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          CheckboxListTile(
            title: const Text('Item 1'),
            value: checkSet.contains(1),
            onChanged: (value) {
              checkSet.toggle(1);
            },
          ),
          CheckboxListTile(
            title: const Text('Item 3'),
            value: checkSet.contains(3),
            onChanged: (value) {
              checkSet.toggle(3);
            },
          ),
          CheckboxListTile(
            title: const Text('Item 2'),
            value: checkSet.contains(2),
            onChanged: (value) {
              checkSet.toggle(2);
            },
          ),
        ],
      ),
    );
  }
}



_SetHookState<T> useSetHook<T>() {
  return use(_SetHook<T>());
}

//
class _SetHook<T> extends Hook<_SetHookState<T>> {
  const _SetHook();

  @override
  _SetHookState<T> createState() => _SetHookState<T>();
}
//
class _SetHookState<T> extends HookState<_SetHookState<T>, _SetHook<T>> {
  late Set<T> set;//is used to store the selected items

  @override
  void initHook() {
    super.initHook();
    set = {};

  }

  add(T val) {
    setState(() {
      set.add(val);
    });
  }

  toggle(T val) {
    setState(() {
      if (contains(val)) {
        remove(val);
      } else {
        add(val);
      }
    });
  }

  remove(T val) {
    setState(() {
      set.remove(val);
    });
  }

  bool contains(T val) => set.contains(val);

  List<T> getChecked() => set.toList();

  @override
  _SetHookState<T> build(BuildContext context) => this;
}