import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_con.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List items = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Todo List')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigatorToAddscreen,
        child: const Text(
          'TODO Add',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: getTodo,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              final id = item["_id"] as String;
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(item['title']),
                subtitle: Text(item['description']),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'edit') {
                      navigatorToEditscreen(item);
                    }
                    if (value == 'delete') {
                      deleteById(id);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              );
            },
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> navigatorToEditscreen(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => ScondScreen(todo: item),
    );
    await Navigator.of(context).push(route);
    setState(() {
      isLoading = true;
    });
    getTodo();
  }

  Future<void> navigatorToAddscreen() async {
    final route = MaterialPageRoute(
      builder: (context) => const ScondScreen(),
    );
    await Navigator.of(context).push(route);
    setState(() {
      isLoading = true;
    });
    getTodo();
  }

  Future<void> getTodo() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final respons = await http.get(uri);
    if (respons.statusCode == 200) {
      final json = jsonDecode(respons.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteById(id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final item = items.where((element) => (element)['_id'] != id).toList();
      setState(() {
        items = item;
      });
    } else {
      showScatforldMassegFalse('Delete is Field');
    }
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
