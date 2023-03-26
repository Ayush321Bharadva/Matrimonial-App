import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/pages/homepage.dart';

class FavouritesPage extends StatefulWidget {
  final List<User> allUsers;

  const FavouritesPage({Key? key, required this.allUsers}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final List<User> _likedUsers = [];

  @override
  // void initState() {
  //   super.initState();
  //   _getLikedUsers();
  // }

  // void _getLikedUsers() {
  //   _likedUsers = widget.allUsers.where((user) => user.isLiked).toList();
  // }

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
          'Liked Users',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
      body: _likedUsers.isNotEmpty
          ? ListView.builder(
        itemCount: _likedUsers.length,
        itemBuilder: (context, index) {
          User user = _likedUsers[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.city),
          );
        },
      )
          : const Center(
        child: Text('No any Favourite Users!!'),
      ),
    );
  }
}