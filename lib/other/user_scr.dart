import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

TextStyle namestyle2() {
  return GoogleFonts.zeyada(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 38,
      fontWeight: FontWeight.normal,
    ),
  );
}

class _StudentScreenState extends State<StudentScreen> {
  String? user_email;
  Future<String?>? user_dp_future; // Use a Future for user_dp

  @override
  void initState() {
    super.initState();
    user_email = FirebaseAuth.instance.currentUser!.email;
    getUserImg();
  }

  Future<String?> getUserImg() async {
    String imgpath = 'user-images/$user_email/$user_email.jpg';

    try {
      String user_dp_url =
          await FirebaseStorage.instance.ref().child(imgpath).getDownloadURL();
      setState(() {
        user_dp_future =
            Future.value(user_dp_url); // Update the Future with the image URL
      });
      return user_dp_url;
    } catch (e) {
      // Handle any errors, such as the image not being available
      print('Error loading profile image: $e');
      setState(() {
        user_dp_future =
            Future.value(null); // Update the Future with null value
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final email = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 239, 239),
      drawer: FractionallySizedBox(
        widthFactor: 0.75,
        child: Drawer(
          child: Column(
            children: [
              Container(
                // color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, top: 10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: Builder(
          builder: (BuildContext context) {
            return Align(
              alignment:
                  Alignment.centerLeft, // Set the alignment to center-left
              child: IconButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color.fromARGB(255, 44, 43, 43),
                  child: FutureBuilder<String?>(
                    future: user_dp_future, // Use the Future here
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        ); // Show a loading indicator while fetching the image URL
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return ClipOval(
                          child: Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            height: 39,
                            width: 39,
                          ),
                        ); // Display the image if available
                      } else {
                        return const Text(
                            '!'); // Display a message if the image is not available
                      }
                    },
                  ),
                ),
                iconSize: 28,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            );
          },
        ),
        title: Row(
          children: [
            const SizedBox(
              width: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'SHOPWISE',
                style: namestyle2(),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
