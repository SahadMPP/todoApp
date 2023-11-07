import 'package:flutter/material.dart';

class ScondScreen extends StatefulWidget {
  const ScondScreen({super.key});

  @override
  State<ScondScreen> createState() => _ScondScreenState();
}

class _ScondScreenState extends State<ScondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 100),
          child: Text('TODO APP'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const TextField(
            decoration: InputDecoration(hintText: 'Text'),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(hintText: 'Discription'),
            maxLines: 5,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text('Submit'))
        ],
      ),
    );
  }

  void submitData() {
    // get the data from form
    // submit data to the server
    // show success of failer based on status
  }
}
