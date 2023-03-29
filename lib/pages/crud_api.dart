import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/pages/api_insert_users.dart';
import 'package:myproject/pages/api_user_detail.dart';



class CrudApi extends StatefulWidget {
  const CrudApi({super.key});

  @override
  State<CrudApi> createState() => _CrudApiState();
}

class _CrudApiState extends State<CrudApi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Api Users"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return InsertUser(null);
                    },
                  )).then((value) {
                    if (value == true) {
                      setState(() {});
                    }
                  });
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        body: FutureBuilder<http.Response>(
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const APIUserDetail()
                      )).then((value) {
                        if (value == true) {
                          setState(() {});
                        }
                      });
                    },
                    child: Card(
                      color: index % 2 == 0 ? Colors.white12 : Colors.white38,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              (jsonDecode(snapshot.data!.body.toString())[
                              index]['Name'])
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDeleteAlert((jsonDecode(
                                  snapshot.data!.body.toString())[index]
                              ['id']));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: jsonDecode(snapshot.data!.body).length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: getData(),
        ),
      ),
    );
  }

  Future<http.Response> getData() async {
    var response = await http
        .get(Uri.parse("https://62dbcd92d1d97b9e0c543e75.mockapi.io/users"));
    return response;
  }

  Future<http.Response> getDataById(id) async {
    // var id;
    var response = await http
        .get(Uri.parse("https://62dbcd92d1d97b9e0c543e75.mockapi.io/users/$id"));
    return response;
  }

  Future<http.Response> deleteUser(id) async {
    var response = await http.delete(
      Uri.parse("https://62dbcd92d1d97b9e0c543e75.mockapi.io/users/$id"),
    );
    return response;
  }

  void showDeleteAlert(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alert!"),
          content: const Text("Are you sure want to delete this record?"),
          actions: [
            TextButton(
              onPressed: () async {
                http.Response res = await deleteUser(id);

                if (res.statusCode == 200) {
                  setState(() {});
                }
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
