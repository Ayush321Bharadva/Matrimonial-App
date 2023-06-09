import 'package:flutter/material.dart';
import 'package:myproject/database/database.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/pages/user_list.dart';

class EditUser extends StatefulWidget {
  final User user;

  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _city;
  late String _description;
  String _genderValue = '';

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _city = widget.user.city;
    _description = widget.user.description;
    _genderValue = widget.user.gender;
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
          'Edit User',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
        leading: null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                const SizedBox(
                  height: 16,
                ),
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
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  initialValue: _city,
                  decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder(),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter City';
                    }
                    return null;
                  },
                  onSaved: (value) => _city = value!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  initialValue: _description,
                  decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder(),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value!,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _updateUser();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserList(),
        ),
      );
    }
  }

  void _updateUser() {
    final updatedUser = widget.user.copyWith(
        name: _name, city: _city, gender: _genderValue, description: _description);
    DatabaseProvider.db.update(updatedUser);
  }
}