import 'package:flutter/material.dart';
import 'package:simple_radio_group/simple_radio_group.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleRadioGroupExample(),
    );
  }
}

class SimpleRadioGroupExample extends StatelessWidget {
  const SimpleRadioGroupExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple radio group example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Horizontal"),
            SimpleRadioGroup<String>(
              direction: Axis.horizontal,
              initialValue: "Option 1",
              validator: (String? option) {
                if (option == null) {
                  return "Required";
                }
                return null;
              },
              options: const [
                "Option 1",
                "Option 2",
                "Options 3",
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            const Text("Vertical"),
            SimpleRadioGroup<String>(
              direction: Axis.vertical,
              validator: (String? option) {
                if (option == null) {
                  return "Required";
                }
                return null;
              },
              options: const [
                "Option 1",
                "Option 2",
                "Options 3",
              ],
            ),
          ],
        ),
      ),
    );
  }
}
