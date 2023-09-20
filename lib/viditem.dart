import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:like_button/like_button.dart';
import 'package:wealthwise/main.dart';

import 'neubox.dart';

class VideoItem extends StatefulWidget {
  String url;
  String emai;
  VideoItem({super.key, required this.url, required this.emai});

  @override
  _VideoItemState createState() => _VideoItemState();
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

TextStyle namestyle4() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 19,
        // fontWeight: FontWeight.normal,
        fontWeight: FontWeight.normal),
  );
}

TextStyle namestyle5() {
  return GoogleFonts.playfairDisplay(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
  );
}

void showdismsnack(BuildContext context) => {
      Flushbar(
        shouldIconPulse: false,
        icon: const Icon(
          Icons.message_outlined,
          color: Colors.black,
        ),
        message: 'Video Saved Successfully',
        // message: 'Video Saved Successfully',
        messageSize: 16,
        messageColor: Colors.white,
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 2, 8, 0),
        duration: const Duration(milliseconds: 2200),
        padding: const EdgeInsets.all(24),
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        borderRadius: BorderRadius.circular(20),
        barBlur: 15,
        backgroundColor: Colors.black.withOpacity(0.5),
        backgroundGradient: LinearGradient(colors: [
          Colors.black,
          Theme.of(context).colorScheme.primary,
          const Color.fromARGB(255, 64, 64, 64),
        ]),
      )..show(context)
    };

class _VideoItemState extends State<VideoItem> {
  bool isLiked = false;
  bool is_saved = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: GestureDetector(
          onDoubleTap: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
          child: Flexible(
            child: NeuBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String?>(
                          // future: fetchProfilePictureUrl(widget.emai),
                          future: fetchProfilePictureUrl(widget.emai),
                          builder: (context, profilePicSnapshot) {
                            if (profilePicSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (profilePicSnapshot.hasError) {
                              return Text(
                                  'Error fetching profile picture: ${profilePicSnapshot.error}');
                            } else if (profilePicSnapshot.hasData) {
                              final profilePicUrl = profilePicSnapshot.data;
                              if (profilePicUrl != null) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: ClipOval(
                                    child: Image.network(
                                      profilePicUrl,
                                      width: 39, // Adjust the size as needed
                                      height: 39,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              } else {
                                return const Text(
                                    'No profile picture available');
                              }
                            } else {
                              return const Text('No profile picture available');
                            }
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        FutureBuilder<String?>(
                          future: fetchusernames(widget.emai),
                          builder: (context, profileUserName) {
                            if (profileUserName.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('');
                            } else if (profileUserName.hasError) {
                              return Text(
                                  'Error fetching profile picture: ${profileUserName.error}');
                            } else if (profileUserName.hasData) {
                              final tt = profileUserName.data;
                              if (tt != null) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    tt,
                                    style: namestyle4(),
                                  ),
                                );
                              } else {
                                return const Text(
                                    'No profile picture available');
                              }
                            } else {
                              return const Text('No profile picture available');
                            }
                          },
                        ),
                        const Spacer(),
                        // PopupMenuButton(itemBuilder: )
                        const Icon(
                          Icons.description_outlined,
                          color: Colors.black,
                          size: 31,
                        )
                      ],
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.all(10),
                    child: VideoPlay(videoUrl: widget.url),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 5),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.black,
                          size: 35,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: LikeButton(
                      //     likeCount: 80,
                      //     likeCountPadding: EdgeInsets.only(left: 12),
                      //     bubblesColor: BubblesColor(
                      //         dotPrimaryColor: Colors.black,
                      //         dotSecondaryColor:
                      //             Theme.of(context).colorScheme.primary),
                      //     countPostion: CountPostion.right,
                      //     countBuilder: (likeCount, isLiked, text) {
                      //       final color = isLiked ? Colors.black : Colors.grey;
                      //       return Text(
                      //         text,
                      //         style: TextStyle(
                      //           color: color,
                      //           fontSize: 20,
                      //         ),
                      //       );
                      //     },
                      //     likeBuilder: (isLiked) {
                      //       return Icon(
                      //         !isLiked
                      //             ? Icons.favorite_border_outlined
                      //             : Icons.favorite,
                      //         color: !isLiked
                      //             ? Colors.black
                      //             : const Color.fromARGB(255, 255, 0, 0),
                      //         size: 35,
                      //       );
                      //     },
                      //   ),
                      // ),
                      const Spacer(),
          
                      IconButton(
                        onPressed: () {
                          setState(() {
                            is_saved = !is_saved;
                          });
                          if (is_saved) {
                            showdismsnack(context);
                          }
                        },
                        icon: Icon(
                          is_saved
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
