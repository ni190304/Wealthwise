import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:wealthwise/info2.dart';
import 'package:wealthwise/tutor/educator_scr.dart';
import 'package:wealthwise/user_scr.dart';
import 'package:wealthwise/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'auth.dart';
import 'info.dart';

class Start extends StatefulWidget {
  const Start({
    super.key,
  });

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    isInternetConnected();
  }

  Future<void> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      isConnected = (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream:
          Connectivity().onConnectivityChanged.map((ConnectivityResult result) {
        return (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi);
      }),
      initialData: true,
      builder: (context, snapshot) {
        final bool isInternetConnected = snapshot.data ?? false;
        if (isInternetConnected) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.from(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(159, 8, 7, 35),
              ),
            ),
            title: 'Wealthwise',
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, authSnapshot) {
                if (authSnapshot.hasData && authSnapshot.data != null) {
                  final currentEmail = authSnapshot.data!.email;
                  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('Tutor')
                        .doc(currentEmail)
                        .snapshots(),
                    builder: (context, tutSnapshot) {
                      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('Student')
                            .doc(currentEmail)
                            .snapshots(),
                        builder: (context, studSnapshot) {
                          if (authSnapshot.connectionState ==
                                  ConnectionState.waiting ||
                              tutSnapshot.connectionState ==
                                  ConnectionState.waiting ||
                              studSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return const Splash();
                          }

                          if (authSnapshot.connectionState ==
                              ConnectionState.active) {
                            if (authSnapshot.hasData) {
                              if (tutSnapshot.connectionState ==
                                      ConnectionState.active &&
                                  tutSnapshot.hasData &&
                                  tutSnapshot.data!.exists) {
                                return const TutorScreen();
                              } else if (studSnapshot.connectionState ==
                                      ConnectionState.active &&
                                  studSnapshot.hasData &&
                                  studSnapshot.data!.exists) {
                                return const StudentScreen();
                              } else {
                                return const Info2();
                              }
                            } else {
                              return const AuthScreen();
                            }
                          }

                          return const Splash();
                        },
                      );
                    },
                  );
                } else {
                  return const AuthScreen();
                }
              },
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  height: 300,
                  width: 250,
                  child: Lottie.asset('lib/animations/internet.json'),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
