import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  late StreamController<List<String>> _budgetEmailsController;
  final currentemail = FirebaseAuth.instance.currentUser!.email;
  late int budgetcounter = 0; 

  @override
  void initState() {
    super.initState();
    _budgetEmailsController = StreamController<List<String>>();
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

  Future<int> _getBudgetCounter(String eemail) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(eemail)
        .get();

    return snapshot['a'];
  }

  Future<List<String>> fetchVideoUrls(String eemail) async {
    List<String> videoUrls = [];

    int counter = await _getBudgetCounter(eemail);

    for (int j = 2; j <= counter; j++) {
      final budgetvideoFilename = 'video__${eemail}_budget_$j.mp4';

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

  @override
  void dispose() {
    _budgetEmailsController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<String>>(
              stream: _budgetEmailsController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error: Something went wrong'));
                } else if (snapshot.hasData) {
                  List<String> budgetEmails = snapshot.data!;

                  return budgetEmails.isNotEmpty
                      ? ListView.builder(
                          itemCount: budgetEmails.length,
                          itemBuilder: (context, index) {
                            String email = budgetEmails[index];

                            return FutureBuilder<List<String>>(
                              future: fetchVideoUrls(email),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  List<String> videoUrls = snapshot.data!;

                                  List<Widget> videos = [];

                                  for (String videourl in videoUrls) {

                                    print(videourl);
                                    
                                    VideoPlayerController _controller = 
                                        VideoPlayerController.networkUrl(videourl as Uri)
                                          ..initialize().then((_) {
                                            // Ensure the first frame is shown
                                            setState(() {});
                                          });

                                    videos.add(AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: VideoPlayer(_controller),
                                    ));
                                  }

                                  return Column(children: videos);
                                } else {
                                  return const Text('No videos available');
                                }
                              },
                            );
                          },
                        )
                      : const Center(child: Text('No budget emails available'));
                } else {
                  return const Center(
                      child: Text('No budget emails available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
