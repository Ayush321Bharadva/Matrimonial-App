import 'package:flutter/material.dart';
import 'package:myproject/database/database.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/pages/user_list.dart';

class LikedUsers extends StatefulWidget {
  final List<User> userList;

  const LikedUsers({
    Key? key,
    required this.userList,
  }) : super(key: key);

  @override
  State<LikedUsers> createState() => _LikedUsersState();
}

class _LikedUsersState extends State<LikedUsers> {
  final dbHelper = DatabaseProvider.db;

  @override
  Widget build(BuildContext context) {
    final likedUsers = widget.userList.where((user) => user.isLiked).toList();
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
            'Liked Users',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
          ),
          leading: IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const UserList()));
            },
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: likedUsers.length,
        itemBuilder: (BuildContext context, int index) {
          final user = likedUsers[index];
          return Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            
            
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  user.name,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  user.city,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: user.isLiked ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    user.isLiked = !user.isLiked;
                    dbHelper.likedUser(user);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
