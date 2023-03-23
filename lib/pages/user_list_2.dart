import 'package:flutter/material.dart';
import 'package:myproject/database/database.dart';
import 'package:myproject/models/model.dart';

class UserList2 extends StatefulWidget {
  const UserList2({Key? key}) : super(key: key);

  @override
  State<UserList2> createState() => _UserList2State();
}

class _UserList2State extends State<UserList2> {
  late final User user;
  final dbHelper = DatabaseProvider.db;
  late final User updatedUser;
  // List<User> userList = [];
  List<User> filteredUserList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    final list = await dbHelper.getAllUsers();
    setState(() {
      // userList = list;
      filteredUserList = list;
    });
  }

  Future<void> _deleteUser(int id) async {
    final count = await dbHelper.delete(id);
    if (count > 0) {
      _deleteUser(id);
    }
  }

  void _searchUsers(String searchQuery) {
    List<User> results = [];
    for (var user in filteredUserList) {
      if (user.name.toLowerCase().contains(searchQuery.toLowerCase())) {
        results.add(user);
      }
    }
    setState(() {
      filteredUserList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List page 2'),
      ),
      body: ListView.builder(
        itemCount: filteredUserList.length,
        itemBuilder: (BuildContext context, int index) {
          final user = filteredUserList[index];
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue.shade200,
                width: 2.0,
              ),
            ),
            child: ListTile(
              title: Text(user.name),
              subtitle: Text(user.gender),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _deleteUser(user.id!);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
