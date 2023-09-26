import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:wealthwise/actual/dashboard.dart';
import 'package:wealthwise/actual/settings.dart';
import 'package:wealthwise/alternate/home.dart';
import 'package:wealthwise/alternate/your_videos.dart';
import 'package:wealthwise/settings.dart';

import '../alternate/videoupload.dart';
import '../designed_boxes/neubox2.dart';
import 'home.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

TextStyle namestyle1() {
  return GoogleFonts.arya(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 22,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle4() {
  return GoogleFonts.arya(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle2() {
  return GoogleFonts.ebGaramond(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 40,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle3() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}

int _selectedIndex = 0;

PageController _pageController = PageController();

final List<Widget> screens = [
  const Home(),
  const Dashboard(),
  const Sett(),
];

class _UserScreenState extends State<UserScreen> {
  String? user_email;
  Future<String?>? user_dp_future;
  Color colordefault = Colors.white;
  Color? color;
  File? user_image_file;

  @override
  void initState() {
    super.initState();
    user_email = FirebaseAuth.instance.currentUser!.email;
    getUserImg();
  }

  Future<String?> getuserscore(String eemail) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('QuizScore')
        .doc(eemail)
        .get();

    try {
      final user_score = await snapshot['score'];

      return user_score;
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }

  Future<String?> fetchusernames(String eemail) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .doc(eemail)
        .get();

    try {
      final user_name = await snapshot['username'];

      return user_name;
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }

  Future<String?> getUserImg() async {
    String imgpath = '$user_email/profile/$user_email.jpg';

    try {
      String user_dp_url =
          await FirebaseStorage.instance.ref().child(imgpath).getDownloadURL();
      setState(() {
        user_dp_future = Future.value(user_dp_url);
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
    void _onTabTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });

      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);
    }

    TextStyle username() {
      return GoogleFonts.alice(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 23,
          fontWeight: FontWeight.normal,
        ),
      );
    }

    TextStyle score() {
      return GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                  backgroundColor: Colors.black,
                  child: FutureBuilder<String?>(
                    future: user_dp_future, // Use the Future here
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
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
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                'Wealthwise',
                style: namestyle2(),
              ),
            ),
          ],
        ),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(
          //         builder: (context) {
          //           return const VideoUpload();
          //         },
          //       ));
          //     },
          //     icon: const Icon(
          //       Icons.video_camera_back_rounded,
          //       color: Colors.black,
          //       size: 25,
          //     )),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'option1':
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return TutorSett();
                    },
                  ));
                  break;
                case 'option2':
                  FirebaseAuth.instance.signOut();
                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: 'option1',
                  child: Theme(
                    data: ThemeData(
                      highlightColor:
                          Colors.blue, // Set your desired background color here
                    ),
                    child: Text(
                      'Settings',
                      style: namestyle3(),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'option2',
                  child: Theme(
                    data: ThemeData(
                      highlightColor:
                          Colors.blue, // Set your desired background color here
                    ),
                    child: Text(
                      'Logout',
                      style: namestyle3(),
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      drawer: FractionallySizedBox(
        widthFactor: 0.9,
        child: Drawer(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ListTile(
                        leading: const Neubox2(
                          child: Icon(
                            Icons.clear_outlined,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.black,
                      child: FutureBuilder<String?>(
                        future: user_dp_future,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ); // Show a loading indicator while fetching the image URL
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            return ClipOval(
                              child: Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                                height: 119,
                                width: 119,
                              ),
                            ); // Display the image if available
                          } else {
                            return const Text(
                                '!'); // Display a message if the image is not available
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FutureBuilder<String?>(
                      future: fetchusernames(user_email!),
                      builder: (context, profileUserName) {
                        if (profileUserName.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (profileUserName.hasError) {
                          return Text(
                              'Error fetching profile username: ${profileUserName.error}');
                        } else if (profileUserName.hasData) {
                          final tt = profileUserName.data;
                          if (tt != null) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                tt,
                                style: username(),
                              ),
                            );
                          } else {
                            return const Text('No profile picture available');
                          }
                        } else {
                          return const Text('No profile picture available');
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<String?>(
                      future: getuserscore(user_email!),
                      builder: (context, profileUserScore) {
                        if (profileUserScore.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (profileUserScore.hasError) {
                          return Text(
                              'Error fetching profile score: ${profileUserScore.error}');
                        } else if (profileUserScore.hasData) {
                          final tt = profileUserScore.data;
                          if (tt != null) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Quiz Score : $tt',
                                  style: score(),
                                ),
                              ),
                            );
                          } else {
                            return const Text('No profile picture available');
                          }
                        } else {
                          return const Text('No profile picture available');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                
                title: Text(
                  'View Profile',
                  style: namestyle1(),
                ),
                leading: const Icon(
                  Icons.person_outline_outlined,
                  size: 26,
                  color: Colors.black,
                ),
              ),
              ExpansionTile(
                title: Text(
                  'Module Analysis',
                  style: namestyle1(),
                ),
                leading: const Icon(
                  Icons.analytics_outlined,
                  size: 26,
                  color: Colors.black,
                ),
                childrenPadding: EdgeInsets.only(left: 90),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(5),
                    title: Text(
                      'Budgeting',
                      style: namestyle4(),
                    ),
                    trailing: const Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(5),
                    title: Text(
                      'Investing',
                      style: namestyle4(),
                    ),
                    trailing: const Icon(
                      Icons.monetization_on,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(5),
                    title: Text(
                      'Loans',
                      style: namestyle4(),
                    ),
                    trailing: const Icon(
                      Icons.credit_card,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(5),
                    title: Text(
                      'Stocks',
                      style: namestyle4(),
                    ),
                    trailing: const Icon(
                      Icons.show_chart,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(
            color: Color.fromARGB(255, 227, 223, 223),
            thickness: 0.9,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SafeArea(
                child: PageView(
                  controller: _pageController,
                  children: screens,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 23,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              size: 29,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_collection_outlined,
              size: 23,
            ),
            label: 'Your Videos',
            activeIcon: Icon(
              Icons.video_collection,
              size: 29,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              size: 23,
            ),
            label: 'Settings',
            activeIcon: Icon(
              Icons.settings,
              size: 29,
            ),
          ),
        ],
      ),
    );
  }
}
