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
  List _items = List.generate(20, (i) => i);
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
      body: ReorderableListView.builder(
        itemCount: _items.length,
        itemBuilder: (c, i){
          return Dismissible(
            key: ValueKey(_items[i]),
            background: Container(
              color: Colors.green,
            ),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text('Student ${_items[i]}'),
            ),
            onDismissed: (direction) {
              setState(() {
                _items.removeAt(i);
              });
            },
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            _items.insert(newIndex, _items.removeAt(oldIndex));
          });
        },
      ),
    );
  }
}
