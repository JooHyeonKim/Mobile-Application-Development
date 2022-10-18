import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isChecked = false;
  var _isChecked2 = false;
  var _isChecked3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){},
          ),
        ],
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Test'),
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Test'),
            value: _isChecked2,
            onChanged: (value) {
              setState(() {
                _isChecked2 = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Test'),
            value: _isChecked3,
            onChanged: (value) {
              setState(() {
                _isChecked3 = value!;
              });
            },
          ),
        ],
      )
    );
  }
}



