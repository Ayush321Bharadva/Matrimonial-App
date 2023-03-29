import 'package:flutter/material.dart';
import 'package:myproject/database/database.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/pages/edit_user.dart';
import 'package:myproject/pages/favourites_page.dart';
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
  late List<User> users;
  late List<User> likedUsers;

  @override
  void initState() {
    super.initState();
    _getUsers();
    likedUsers = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            // Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                final likedUsers =
                    userList.where((user) => user.isLiked).toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LikedUsers(
                      userList: likedUsers,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
                  return Container();
                }
                return Container(
                  width: 70,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(20),
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
                    trailing: Wrap(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: user.isLiked ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              user.isLiked = !user.isLiked;
                              dbHelper.likedUser(user);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Saved to Liked'),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditUser(user: user)));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Delete !',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: const Text(
                                    'Are you sure you want to delete this user?',
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FloatingActionButton.extended(
                                          label: const Text('Cancel'),
                                          backgroundColor: Colors.blueGrey,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FloatingActionButton.extended(
                                          label: const Text('Delete'),
                                          backgroundColor: Colors.blueGrey,
                                          onPressed: () {
                                            _deleteUser(user.id!);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const UserList()));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'User Deleted Successfully!!',
                                                ),
                                                backgroundColor:
                                                    Colors.blueGrey,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
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
    );
  }

  Future<void> _getUsers() async {
    final list = await dbHelper.getAllUsers();
    setState(() {
      userList.clear();
      userList.addAll(list);
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
