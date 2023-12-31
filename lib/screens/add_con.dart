import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScondScreen extends StatefulWidget {
  final Map? todo;
  const ScondScreen({super.key, this.todo});

  @override
  State<ScondScreen> createState() => _ScondScreenState();
}

class _ScondScreenState extends State<ScondScreen> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController dicriptionEditingContorller = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      isEdit = true;

      titleEditingController.text = widget.todo!['title'];
      dicriptionEditingContorller.text = widget.todo!['description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: isEdit ? const Text('Edit Todo') : const Text('Add Todo'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleEditingController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: dicriptionEditingContorller,
            decoration: const InputDecoration(hintText: 'Discription'),
            maxLines: 5,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: isEdit ? updateDate : submitData,
              child: Text(isEdit ? 'Update' : 'Submit'))
        ],
      ),
    );
  }

  Future<void> updateDate() async {
    final todo = widget.todo;
    if (todo == null) {
      print('id is null');
      return;
    }

    // final isCombleate = todo["is_completed"];
    // get the data from form
    final title = titleEditingController.text;
    final discription = dicriptionEditingContorller.text;
    final body = {
      "title": title,
      "description": discription,
      "is_completed": false
    };
    // submit data to the server

    final id = todo['_id'];
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final responce = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    // show success of failer based on status
    if (responce.statusCode == 200) {
      titleEditingController.text = '';
      dicriptionEditingContorller.text = '';
      showScatforldMassegTrue('Creation succuess');
    } else {
      showScatforldMassegFalse('Creation failer');
      // ignore: avoid_print
      print(responce.body);
    }
  }

  void submitData() async {
    // get the data from form
    final title = titleEditingController.text;
    final discription = dicriptionEditingContorller.text;
    final body = {
      "title": title,
      "description": discription,
      "is_completed": false
    };
    // submit data to the server
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final responce = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    // show success of failer based on status
    if (responce.statusCode == 201) {
      titleEditingController.text = '';
      dicriptionEditingContorller.text = '';
      showScatforldMassegTrue('Creation succuess');
    } else {
      showScatforldMassegFalse('Creation failer');
      // ignore: avoid_print
      print(responce.body);
    }
  }

  showScatforldMassegTrue(String massege) {
    final snackBar = SnackBar(
      content: Text(massege),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showScatforldMassegFalse(String massege) {
    final snackBar = SnackBar(
      content: Text(
        massege,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
