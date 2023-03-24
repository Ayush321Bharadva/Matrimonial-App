import 'package:flutter/material.dart';
import 'package:myproject/pages/add_user.dart';
import 'package:myproject/database/database.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/pages/edit_user.dart';
import 'package:myproject/pages/homepage.dart';
import 'package:myproject/pages/user_detail.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final dbHelper = DatabaseProvider.db;
  List<User> userList = [];
  String filter = '';

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[300],
          title: const Text(
            'User List',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  filter = val.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "search users",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                final user = userList[index];
                if (!user.name.toLowerCase().contains(filter)) {
                  return const Center(
                    child: Text('No Users Currently!!'),
                  );
                }
                return Container(
                  width: 70,
                  padding: const EdgeInsets.only(top: 18, bottom: 18),
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CardText(user: user),
                    ),
                    subtitle: Text(
                      user.city,
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditUser(
                              user: user,
                            ),
                          ),
                        );
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteUser(user.id!);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserList()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User Deleted Successfully!!'),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetail(
                            user: user,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 100,
        child: FloatingActionButton(
          backgroundColor: Colors.green[300],
          onPressed: () {
            //navigate to add person page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddUser(),
              ),
            ).then((value) => _getUsers());
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Future<void> _getUsers() async {
    final list = await dbHelper.getAllUsers();
    setState(() {
      userList = list;
    });
  }

  Future<void> _deleteUser(int id) async {
    final count = await dbHelper.delete(id);
    if (count > 0) {
      _deleteUser(id);
    }
  }
}

class CardText extends StatelessWidget {
  const CardText({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Text(
      user.name,
      style: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
    );
  }
}
