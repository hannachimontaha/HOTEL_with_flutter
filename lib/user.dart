import 'dart:convert';
import 'package:firebase_formAuth/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//void main() => runApp(MyAppRestaurations());

List<user> postFromJson(String str) =>
    List<user>.from(json.decode(str).map((x) => user.fromMap(x)));

class user {
  int userId;
  String username;
  int password;

  user({
    required this.userId,
    required this.username,
    required this.password,
  });

  factory user.fromMap(Map<String, dynamic> json) => user(
    userId: json["userId"],
    username: json["username"],
    password: json["password"],
  );
}

Future<List<user>> fetchUser() async {
  final response =
  await http.get(Uri.parse('http://192.168.43.35:8084/user'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<user>((json) => user.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}

class MyAppUsers extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppUsers> {
  late Future<List<user>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Container(
              child: Text(
                'Liste des utilisateurs :',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: hexStringToColor("632161"),
          ),
          body: new Container(
            child: new FutureBuilder<List<user>>(
              future: futureUsers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Color(0xff264e70),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Id utilisateur : " +
                                  "${snapshot.data![index].userId}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 10),
                            Text(
                              "Nom : " + "${snapshot.data![index].username}",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                         
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ));
  }
}
