import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_formAuth/screens/signin_screen.dart';
import 'package:firebase_formAuth/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//void main() => runApp(MyAppRestaurations());

List<reservation> postFromJson(String str) =>
    List<reservation>.from(json.decode(str).map((x) => reservation.fromMap(x)));

class reservation {
  int id;
  String client_name;
  int nbr_nuits;
  int nbr_chambres;
  int nbr_adultes;
  int nbr_enfants;
  String date_reservation;
  int user_id;

  reservation({
    required this.id,
    required this.client_name,
    required this.nbr_nuits,
    required this.nbr_chambres,
    required this.nbr_adultes,
    required this.nbr_enfants,
    required this.date_reservation,
    required this.user_id,
  });

  factory reservation.fromMap(Map<String, dynamic> json) => reservation(
        id: json["id"],
        client_name: json["client_name"],
        nbr_nuits: json["nbr_nuits"],
        nbr_chambres: json["nbr_chambres"],
        nbr_adultes: json["nbr_adultes"],
        nbr_enfants: json["nbr_enfants"],
        date_reservation: json["date_reservation"],
        user_id: json["user_id"],
      );
}

Future<List<reservation>> fetchReservation() async {
  final response =
      await http.get(Uri.parse('http://192.168.43.35:8084/reservation'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed
        .map<reservation>((json) => reservation.fromMap(json))
        .toList();
  } else {
    throw Exception('Failed to load reservation');
  }
}

class MyAppReservations extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppReservations> {
  late Future<List<reservation>> futureReservations;
  int _selectedIndex = 0;
  var _display = 'Home Selected';

  @override
  void initState() {
    super.initState();
    futureReservations = fetchReservation();
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
          title: Text("Liste des reservations :"),
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
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     onPrimary: Colors.white,
                  //     primary: hexStringToColor("632161"),
                  //     minimumSize: const Size(88, 36),
                      
                  //     padding: const EdgeInsets.symmetric(horizontal: 30),
                  //     shape: const RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(10))),
                  //   ),
                  //   onPressed: () {
                  //      Navigator.pushNamed(context, "/add-reservation");
                  //   },
                  //   child: const Text("Réserver"),
                  // ),
                  FutureBuilder<List<reservation>>(
                    future: futureReservations,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 226, 226, 226),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Id du reservation : " +
                                        "${snapshot.data![index].id}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  
                                  SizedBox(height: 10),
                                  Text(
                                    "Nom du Client : " +
                                        "${snapshot.data![index].client_name}",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Nombre du nuits : " +
                                        "${snapshot.data![index].nbr_nuits}",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Nombre des adultes  : " +
                                        "${snapshot.data![index].nbr_adultes}",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Nombre des enfants : " +
                                        "${snapshot.data![index].nbr_enfants}",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Nombres des chambres : " +
                                        "${snapshot.data![index].nbr_chambres}",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Date de reservation : " +
                                        "${snapshot.data![index].date_reservation}",
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
                ]),
              ]),
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
      ),
      ),
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
