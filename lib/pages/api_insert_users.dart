import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertUser extends StatefulWidget {
  InsertUser(this.map, {super.key});

  Map? map;

  @override
  State<InsertUser> createState() => InsertUserState();
}

class InsertUserState extends State<InsertUser> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var genderController = TextEditingController();
  var cityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.map == null ? '' : widget.map!['Name'];
    genderController.text = widget.map == null ? '' : widget.map!['Gender'];
    cityController.text = widget.map == null ? '' : widget.map!['City'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Enter Name"),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter Valid Name";
                  }
                },
                controller: nameController,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Enter Gender"),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter Valid Gender";
                  }
                },
                controller: genderController,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Enter City"),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter Valid City";
                  }
                },
                controller: cityController,
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (widget.map == null) {
                      insertUser()
                          .then((value) => Navigator.of(context).pop(true));
                    } else {
                      updateUser(widget.map!['id'])
                          .then((value) => Navigator.of(context).pop(true));
                    }
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> insertUser() async {
    Map map = {};
    map["Name"] = nameController.text;
    map["Gender"] = genderController.text;
    map["City"] = cityController.text;

    var response = await http.post(
        Uri.parse("https://62dbcd92d1d97b9e0c543e75.mockapi.io/users"),
        body: map);
  }

  Future<void> updateUser(id) async {
    Map map = {};

    map["Name"] = nameController.text;
    map["City"] = cityController.text;
    map["Gender"] = genderController.text;

    var response = await http.put(
        Uri.parse("https://62dbcd92d1d97b9e0c543e75.mockapi.io/users/$id"),
        body: map);
  }
}
