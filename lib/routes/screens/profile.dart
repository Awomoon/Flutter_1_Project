import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:moon_store/widgets/modals/hive_modal.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<User>('userBox');
    final user = userBox.get('user');
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/bg.jpg'),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avater.jpg'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Hello there ${user!.username}',
                    style: GoogleFonts.lexend(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(user.email,
                      style: GoogleFonts.lexend(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 40),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    trailing: Icon(CupertinoIcons.arrow_right_circle),
                    onTap: () => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Color.fromRGBO(123, 97, 255, 1),
                          duration: Duration(seconds: 2),
                          content: Text(
                            'Coming Soon!!!',
                            style: GoogleFonts.lexend(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    },
                  ),
                  Divider(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Order History'),
                    trailing: Icon(CupertinoIcons.arrow_right_circle),
                    onTap: () => {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(
                          'Coming Soon!!!',
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Color.fromRGBO(123, 97, 255, 1),
                      ))
                    },
                  ),
                  Divider(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    trailing: Icon(CupertinoIcons.arrow_right_circle),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Confirm Logout',
                                      style: GoogleFonts.lexend(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            content: Text('Are you sure you want to Logout?'),
                            contentTextStyle: GoogleFonts.lexend(
                                fontSize: 20, color: Colors.black),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            // icon: Icon(Icons.question_answer),
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.red)),
                                onPressed: () {
                                  final userBox = Hive.box<User>('userBox');
                                  userBox.clear();
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                                child: Text(
                                  'Yes',
                                  style:
                                      GoogleFonts.lexend(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.green)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No',
                                  style:
                                      GoogleFonts.lexend(color: Colors.white),
                                ),
                              ),
                            ],
                            elevation: 20,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
