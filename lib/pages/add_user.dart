import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/pages/homepage.dart';
import 'package:myproject/pages/user_list.dart';
import 'package:myproject/database/database.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _genderValue = '';
  final dbHelper = DatabaseProvider.db;

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[300],
        title: const Text(
          'Add User',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
            const HomePage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name text field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                // Gender Radio button
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                  ),
                  child: Wrap(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Male'),
                              value: 'Male',
                              groupValue: _genderValue,
                              onChanged: (value) {
                                setState(() {
                                  _genderValue = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Female'),
                              value: 'Female',
                              groupValue: _genderValue,
                              onChanged: (value) {
                                setState(() {
                                  _genderValue = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // City text field
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Description text field
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Save/Add button
                Center(
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final user = User(
                          name: _nameController.text,
                          gender: _genderValue,
                          city: _cityController.text,
                          description: _descriptionController.text,
                        );
                        await dbHelper.insert(user);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User Added Successfully!!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        _nameController.clear();
                        // _genderController.clear();
                        _genderValue.trim();
                        _cityController.clear();
                        _descriptionController.clear();
                      }
                      Navigator.of(context).pop();
                    },
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.add),
                    label: const Text('Add User'),
                  ),
                ),
                const SizedBox(height: 16),
                // Save/Add button
                Center(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserList(),
                        ),
                      );
                    },
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.add),
                    label: const Text('Display Users'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//fields for user add
/*
name,gender,dob,religion,caste,location/address,about me,hobbies,photo,height,
marital status.
db table :-
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    gender VARCHAR(10),
    name VARCHAR(255),
    date_of_birth DATE,***
    marital_status VARCHAR(20),
    religion VARCHAR(50),***
    caste VARCHAR(50),***
    education_level VARCHAR(50),
    occupation VARCHAR(50),
    annual_income INT,
    height INT,
    weight INT,
    location_address VARCHAR(255),
    about_me TEXT,
    hobbies_interests TEXT,
    photos TEXT,***
);
*/