import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name : ${user.name}'),
            Text('Gender : ${user.gender}'),
            Text('City : ${user.city}'),
            Text('Description : ${user.description}'),
          ],
        ),
      ),
    );
  }
}
