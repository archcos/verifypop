import 'package:flutter/material.dart';
import 'package:flutter_laravel/services/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = new FlutterSecureStorage();


  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token: token);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Quality Detection System'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
      drawer: Drawer(
        key: UniqueKey(),
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            if (auth.authenticated) {
              return ListView(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade700, Colors.blue.shade900],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: auth.user.avatar?.startsWith('http') ?? false
                                    ? NetworkImage(auth.user.avatar)
                                    : AssetImage('user.png'),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  color: Colors.grey,
                                  onPressed: () {
                                    // handle edit image button press
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                auth.user.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "@${auth.user.username}",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ],
                      )
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      Provider.of<Auth>(context, listen: false).logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                      );
                    },
                  ),
                ],
              );
            } else {
              // add a return statement here
              return Container();
            }
          },
        ),
      ),
    );
  }
}
