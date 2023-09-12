import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';
import 'package:wealthwise/splash.dart';

class Budget1 extends StatefulWidget {
  const Budget1({Key? key}) : super(key: key);

  @override
  State<Budget1> createState() => _Budget1State();
}

class _Budget1State extends State<Budget1> {
  late StreamController<List<String>> _budgetEmailsController;
  final currentemail = FirebaseAuth.instance.currentUser!.email;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _budgetEmailsController = StreamController<List<String>>();
_videoPlayerController = VideoPlayerController.network('https://firebasestorage.googleapis.com/v0/b/wealthwise-739c2.appspot.com/o/tutor1%40gmail.com%2Fvideos%2FBudgeting%2Fvideo__tutor1%40gmail.com_Budgeting_1.mp4?alt=media&token=c1831bfb-c667-4a38-8790-696f417e4f92');
    _loadBudgetEmails();
  }

  Future<void> _loadBudgetEmails() async {
    List<String> budgetEmails = [];

    CollectionReference businessCollection =
        FirebaseFirestore.instance.collection('Budgeting');

    QuerySnapshot querySnapshot = await businessCollection.get();

    querySnapshot.docs.forEach((doc) {
      String email = doc.get('email');
      if (email != null && email != currentemail) {
        budgetEmails.add(email);
      }
    });

    _budgetEmailsController.add(budgetEmails);
  }

  Future<List<String>> fetchVideoUrls(String eemail, int budgetctr) async {
    List<String> videoUrls = [];

    for (int j = 1; j <= budgetctr; j++) {
      final budgetvideoFilename = 'video__${eemail}_Budgeting_$j.mp4';

      Reference videosReference = FirebaseStorage.instance
          .ref()
          .child(eemail)
          .child('videos')
          .child('Budgeting')
          .child(budgetvideoFilename);

      final videourl = await videosReference.getDownloadURL();

      videoUrls.add(videourl);
    }

    return videoUrls;
  }

  Future<int> _getBudgetCounter(String eemail) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(eemail)
        .get();

    return snapshot['a'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<List<String>>(
        stream: _budgetEmailsController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Splash();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error: Something went wrong'));
          } else if (snapshot.hasData) {
            List<String> budgetemails = snapshot.data!;

            return ListView.builder(
              itemCount: budgetemails.length,
              itemBuilder: (context, index) {
                String email = budgetemails[index];

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder<int>(
                        future: _getBudgetCounter(email),
                        builder: (context, counterSnapshot) {
                          if (counterSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('');
                          } else if (counterSnapshot.hasError) {
                            return Text('Error: ${counterSnapshot.error}');
                          } else if (counterSnapshot.hasData) {
                            int budgetCounter = counterSnapshot.data! - 1;

                            return FutureBuilder<List<String>>(
                              future: fetchVideoUrls(email, budgetCounter),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('');
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final videourls = snapshot.data;

                                  print(videourls);

                                  return Column(
                                    children: [
                                      Text(email),
                                      Text(budgetCounter.toString()),
                                      Text(videourls.toString()),
                                      // VideoPlayer(_videoPlayerController),
                                      const SizedBox(height: 15),
                                    ],
                                  );
                                } else {
                                  return const Text('No videos available');
                                }
                              },
                            );
                          } else {
                            return const Text('No counter available');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No budget emails available'));
          }
        },
      ),
    );
  }
}
