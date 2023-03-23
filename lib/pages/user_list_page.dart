import 'package:flutter/material.dart';
import 'package:myproject/pages/add_user.dart';
import 'package:myproject/database/database.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/pages/user_detail.dart';
import 'package:myproject/pages/edit_user.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late final User user;
  final dbHelper = DatabaseProvider.db;
  late final User updatedUser;
  List<User> userList = [];
  List<User> filteredUserList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List Page'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue.shade200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon((Icons.search)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search Users',
                      border: InputBorder.none,
                    ),
                    onChanged: _searchUsers,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              // height: double.maxFinite,
              // width: 500,
              child: ListView.builder(
                itemCount: filteredUserList.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = filteredUserList[index];
                  return Column(
                    children: [
                      Container(
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
                          subtitle: Text(user.city),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite),
                                onPressed: () {
                                  // Handle like button pressed
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditUser(user: user),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteUser(user.id!);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const UserList(),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('User Deleted Successfully!!'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetail(user: user),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddUser(),
                    ),
                  );
                },
                backgroundColor: Colors.green,
                icon: const Icon(Icons.add),
                label: const Text('Add New User'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getUsers() async {
    final list = await dbHelper.getAllUsers();
    setState(() {
      userList = list;
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
    for (var user in userList) {
      if (user.name.toLowerCase().contains(searchQuery.toLowerCase())) {
        results.add(user);
      }
    }
    setState(() {
      filteredUserList = results;
    });
  }
}
