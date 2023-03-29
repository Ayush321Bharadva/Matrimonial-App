import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/pages/api_insert_users.dart';
import 'package:myproject/pages/crud_api.dart';
import 'package:myproject/pages/user_list.dart';

class Dashboard extends StatelessWidget {
  final List<User> allUsers;

  const Dashboard({Key? key, required this.allUsers}) : super(key: key);

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
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
      ),
      body: Center(
        child: Flexible(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => const UserList(),
                      builder: (context) => const UserList(),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('All Users'),
                ),
              ),
              GestureDetector(
                // onTap: () {
                //   final likedUsers = allUsers.where((user) => user.isLiked).toList();
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => LikedUsers(userList: likedUsers,),
                //     ),
                //   );
                // },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('Favourite Users'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InsertUser(null)));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('API (Insert)'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const CrudApi()));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Text('API (all Users)')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
