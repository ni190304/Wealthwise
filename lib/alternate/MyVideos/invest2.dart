import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';
import 'package:wealthwise/videos/viditem.dart';

class Invest2 extends StatefulWidget {
  const Invest2({Key? key}) : super(key: key);

  @override
  State<Invest2> createState() => _Invest2State();
}

class _Invest2State extends State<Invest2> {
  late StreamController<List<String>> _investEmailController;
  final currentemail = FirebaseAuth.instance.currentUser!.email;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _investEmailController = StreamController<List<String>>();
    _videoPlayerController = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/wealthwise-739c2.appspot.com/o/tutor1%40gmail.com%2Fvideos%2FBudgeting%2Fvideo__tutor1%40gmail.com_Budgeting_1.mp4?alt=media&token=c1831bfb-c667-4a38-8790-696f417e4f92');
    _loadInvestEmails();
  }

  Future<void> _loadInvestEmails() async {
    List<String> investEmails = [];

    CollectionReference businessCollection =
        FirebaseFirestore.instance.collection('Investing and Saving');

    QuerySnapshot querySnapshot = await businessCollection.get();

    querySnapshot.docs.forEach((doc) {
      String email = doc.get('email');
      if (email != null && email == currentemail) {
        investEmails.add(email);
      }
    });

    _investEmailController.add(investEmails);
  }

  Future<List<String>> fetchVideoUrls(String eemail, int investctr) async {
    List<String> videoUrls = [];

    for (int j = 0; j <= investctr - 1; j++) {
      final investvideoFilename = 'video__${eemail}_Investing and Saving_$j.mp4';

      Reference videosReference = FirebaseStorage.instance
          .ref()
          .child(eemail)
          .child('videos')
          .child('Investing and Saving')
          .child(investvideoFilename);

      final videourl = await videosReference.getDownloadURL();

      videoUrls.add(videourl);
    }

    videoUrls.shuffle();

    return videoUrls;
  }

  Future<int> _getInvestCounter(String eemail) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(eemail)
        .get();

    return snapshot['a'];
  }

  Future<String?> fetchProfilePictureUrl(String eemail) async {
    try {
      final profilePicReference = FirebaseStorage.instance
          .ref()
          .child(eemail)
          .child('profile')
          .child('$eemail.jpg');

      final profilePicUrl = await profilePicReference.getDownloadURL();
      return profilePicUrl;
    } catch (e) {
      print('Error fetching profile picture URL: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<List<String>>(
        stream: _investEmailController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error: Something went wrong'));
          } else if (snapshot.hasData) {
            List<String> investemails = snapshot.data!;

            if (investemails.isEmpty) {
              return const Center(child: Text("You haven't added any video related to Investing and Saving"));
            }

            return Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: ListView.builder(
                itemCount: investemails.length,
                itemBuilder: (context, index) {
                  String email = investemails[index];
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<int>(
                          future: _getInvestCounter(email),
                          builder: (context, counterSnapshot) {
                            if (counterSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('');
                            } else if (counterSnapshot.hasError) {
                              return Text('Error: ${counterSnapshot.error}');
                            } else if (counterSnapshot.hasData) {
                              int investCounter = counterSnapshot.data!;

                              return FutureBuilder<List<String>>(
                                future: fetchVideoUrls(email, investCounter),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text('');
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    final videourls = snapshot.data;

                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: videourls!
                                            .map((e) =>
                                                VideoItem(url: e, emai: email))
                                            .toList(),
                                      ),
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
                          height: 25,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("You haven't added any video related to Investing and Saving")
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
