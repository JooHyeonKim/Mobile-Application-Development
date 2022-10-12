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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){},
          ),
        ],
      ),
      body: const MyForm(),
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
  StudentResult studentResult = StudentResult(0, 0, 0, 0, true);

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
                labelText: 'Mid-term exam',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text.';
                } else if (int.tryParse(value) == null) {
                  return 'Please enter some integer.';
                }
                return null;
              },
              onSaved: (value) => studentResult.midTermExam = int.parse(value!),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Final exam',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text.';
                } else if (int.tryParse(value) == null) {
                  return 'Please enter some integer.';
                }
                return null;
              },
              onSaved: (value) => studentResult.finalTermExam = int.parse(value!),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Additional Point',
              ),
              value: studentResult.additionalPoint,
              items: List.generate(11, (i) {
                if (i == 0) {
                  return DropdownMenuItem(
                    value: i,
                    child: const Text('Choose the additional point')
                  );
                }
                return DropdownMenuItem(
                  value: i,
                  child: Text('${i-1} point')
                );

              }),
              onChanged: (value) {
                setState(() {
                  studentResult.additionalPoint = value!;
                });
              },
              validator: (value) {
                if (value == 0) {
                  return 'Please select the point';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                RadioListTile(
                  title: const Text('Team leader (+10)'),
                  value: 10,
                  groupValue: studentResult.teamLeaderPoint,
                  onChanged: (value) {
                    setState(() {
                      studentResult.teamLeaderPoint = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Team member'),
                  value: 0,
                  groupValue: studentResult.teamLeaderPoint,
                  onChanged: (value) {
                    setState(() {
                      studentResult.teamLeaderPoint = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              title: const Text('Absence less than 4'),
              value: studentResult.attendance,
              onChanged: (value){
                setState(() {
                  studentResult.attendance = value!;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text('Enter'),
              onPressed: () {
                setState(() {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Processing data'),
                    ));
                    _formKey.currentState!.save();
                    print(studentResult.toString());
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

class StudentResult {
  int midTermExam;
  int finalTermExam;
  int teamLeaderPoint;
  int additionalPoint;
  bool attendance;

  StudentResult(
    this.midTermExam,
    this.finalTermExam,
    this.teamLeaderPoint,
    this.additionalPoint,
    this.attendance
  );

  @override
  String toString() {
    return '('
        '$midTermExam, '
        '$finalTermExam, '
        '$teamLeaderPoint, '
        '$additionalPoint, '
        '$attendance)';
  }
}
