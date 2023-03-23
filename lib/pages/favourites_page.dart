import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';

class FavouritesPage extends StatefulWidget {
  final List<User> allUsers;

  const FavouritesPage({Key? key, required this.allUsers}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<User> _likedUsers = [];

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
        title: const Text('Favourites'),
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
