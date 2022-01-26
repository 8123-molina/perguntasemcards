import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final textController2 = useTextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(
          controller: textController,
        ),
        TextField(
          controller: textController2,
        ),
      ]),
    );
  }
}
