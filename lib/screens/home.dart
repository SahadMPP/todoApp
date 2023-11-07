import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_con.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('TODO APP')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigatorToAddscreen,
        child: const Text(
          'TODO Add',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  navigatorToAddscreen() {
    final route = MaterialPageRoute(
      builder: (context) => const ScondScreen(),
    );
    Navigator.of(context).push(route);
  }
}
