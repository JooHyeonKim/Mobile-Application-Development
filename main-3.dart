import 'package:flutter/material.dart';

List<String> listPoint = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade Calculator',
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
        fontFamily: 'Cabin',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final items = List.generate(100, (i)=> i).toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text('Grade Calculator'),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.add,
                ),
                onPressed: (){},
              ),
            ],
            bottom: const TabBar(
                tabs: [
                  Tab(text: 'Information'),
                  Tab(text: 'List'),
                ]
            )
          //leading: const Icon(Icons.add),
        ),
        body: const TabBarView(
            children: [
              Tab(
                child: MyForm(),
              ),
              Tab(
                child: MyListPage(),
              ),
            ]
        ),

        drawer: const Drawer(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String currName = '';
  int currProjectPoint = 0;
  int currAdditionalPoint = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text.';
                } else if (double.tryParse(value) != null) {
                  return 'Please enter some string, not a number.';
                }
                return null;
              },
              onSaved: (value) => currName = value!,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Project point',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text.';
                } else if (int.tryParse(value) == null) {
                  return 'Please enter some integer.';
                }
                return null;
              },
              onSaved: (value) => currProjectPoint = int.parse(value!),

            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Additional Point',
              ),
              value: currAdditionalPoint,
              items: List.generate(11, (i) {
                if (i == 0) {
                  return DropdownMenuItem(
                      value: i-1,
                      child: const Text('Choose the additional point')
                  );
                }
                return DropdownMenuItem(
                    value: i-1,
                    child: Text('${i-1} point')
                );

              }),
              onChanged: (value) {
                setState(() {
                  currAdditionalPoint = (value!);
                });
              },
              validator: (value) {
                if (value == -1) {
                  return 'Please select the point';
                }
                return null;
              },
            ),

            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              child: Container(
                  height: 60, color: Colors.indigo,
                  child: const Center(
                    child: Text('Enter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )),
              onTap: () {
                setState(() {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Processing data'),
                    ));
                    _formKey.currentState!.save();
                    listPoint.add('$currName: ${currProjectPoint + currAdditionalPoint}');
                  }
                });
              },
            ),
          ],

        ),
      ),
    );
  }
}

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView.builder(
        itemCount: listPoint.length,
        itemBuilder: (c, i){
          return Dismissible(
            key: ValueKey(listPoint[i]),
            background: Container(
              color: Colors.green,
            ),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text(listPoint[i]),
            ),
            onDismissed: (direction) {
              setState(() {
                listPoint.removeAt(i);
              });
            },
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            listPoint.insert(newIndex, listPoint.removeAt(oldIndex));
          });
        },
      ),
    );
  }
}