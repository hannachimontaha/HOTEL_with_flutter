import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_formAuth/screens/signin_screen.dart';
import 'package:firebase_formAuth/utils/color_utils.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

//void main() => runApp(MyAppRestaurations());

List<activite> postFromJson(String str) =>
    List<activite>.from(json.decode(str).map((x) => activite.fromMap(x)));

class activite {
  int id;
  String nom_activite;
  String date_activite;

  activite({
    required this.id,
    required this.nom_activite,
    required this.date_activite,
  });

  factory activite.fromMap(Map<String, dynamic> json) => activite(
    id: json["id"],
    nom_activite: json["nom_activite"],
    date_activite: json["date_activite"],
  );
}

Future<List<activite>> fetchActivite() async {
  final response =
  await http.get(Uri.parse('http://192.168.43.35:8084/activite'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<activite>((json) => activite.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load activites');
  }
}

class MyAppActivites extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppActivites> {
  late Future<List<activite>> futureActivites;
  int _selectedIndex = 0;
  var _display = 'Home Selected';

  @override
  void initState() {
    super.initState();
    futureActivites = fetchActivite();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
        ),
        home: Scaffold(
          appBar:  AppBar(
            title: Text("Liste des Activité :"),
            backgroundColor: Colors.purple,
            actions: [

              PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                  itemBuilder: (context){
                    return [

                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("Logout"),
                      ),
                    ];
                  },
                  onSelected:(value){
                    if(value == 0){
                      FirebaseAuth.instance.signOut().then((value) {
                        print("Signed Out");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignInScreen()));
                      });
                    };
                  }

              ),

            ],
          ),
          body: new Container(
            child: new FutureBuilder<List<activite>>(
              future: futureActivites,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 226, 226, 226),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Id Activité : " +
                                  "${snapshot.data![index].id}",
                              style: TextStyle(
                                
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 10),

                            Text(
                              "Nom : " + "${snapshot.data![index].nom_activite}",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Date disponibilité : " + "${snapshot.data![index].date_activite}",
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
        bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(Icons.home, color: Colors.white)
          ),
          BottomNavigationBarItem(
              label: 'Activities',
              icon: Icon(Icons.volunteer_activism, color: Colors.white),

          ),
          BottomNavigationBarItem(
              label: 'Reservations',
              icon: Icon(Icons.room_service_outlined, color: Colors.white))
        ],
        backgroundColor: Colors.purple,
        currentIndex: _selectedIndex,
        onTap: _setDisplayed,
      ), )
        );
  }
   void _setDisplayed(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            _selectedIndex = 0;
            _display  = Navigator.pushNamed(context, "/home") as String;
          }
          break;
        case 1:
          {
            _selectedIndex = 1;
            _display  = Navigator.pushNamed(context, "/activites") as String;
          }
          break;
        case 2:
          {
            _selectedIndex = 0;
            _display  = Navigator.pushNamed(context, "/reservations") as String;
          }
          break;
      }
    });
  }
}
