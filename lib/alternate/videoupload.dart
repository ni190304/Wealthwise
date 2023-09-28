import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

import '../designed_boxes/neubox2.dart';
import '../videos/videcat.dart';

class VideoUpload extends StatefulWidget {
  const VideoUpload({super.key});

  @override
  State<VideoUpload> createState() => _VideoUploadState();
}

int vdeoctr = 1;

late int a;
late int b;
late int c;
late int d;

var isaddingvideo = false;

final _videokey = GlobalKey<FormState>();

var selected_category = vidcategories[VideoCategory.budget];

File? videofile;
VideoPlayerController? _videoPlayerController;

TextStyle namestyle1() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle4() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle5() {
  return GoogleFonts.playfairDisplay(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
  );
}

class _VideoUploadState extends State<VideoUpload> {
  var entered_video_title = '';
  var entered_video_description = '';

  final videotitlecontroller = TextEditingController();
  final videodesccontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCounter();
  }

  bool isPlayingVideo = false; // Track if a video is playing

  Future<void> _fetchCounter() async {
    final currentemail = FirebaseAuth.instance.currentUser!.email;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .get();

    if (snapshot.exists) {
      a = snapshot['a'] ?? 0;
      b = snapshot['b'] ?? 0;
      c = snapshot['c'] ?? 0;
      d = snapshot['d'] ?? 0;
    } else {
      await _createUserCounter(currentemail!);
      a = 0;
      b = 0;
      c = 0;
      d = 0;
    }
  }

  Future<void> _createUserCounter(String currentemail) async {
    await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .set({'a': 0, 'b': 0, 'c': 0, 'd': 0});
  }

  Future<void> _updateBudgetCounter() async {
    final currentemail = FirebaseAuth.instance.currentUser!.email;

    await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .update({'a': a + 1});

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .get();

    setState(() {
      a = snapshot['a'];
    });
  }

  Future<void> _updateInvestCounter() async {
    final currentemail = FirebaseAuth.instance.currentUser!.email;

    await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .update({'b': b + 1}); // Increment and update the counter value

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .get();

    setState(() {
      b = snapshot['b'];
    });
  }

  void back() {
    setState(() {
      _videoPlayerController?.dispose();
      setState(() {
        isPlayingVideo = false;
      });
    });
    Navigator.pop(context);
  }

  Future<void> _updateDebtCounter() async {
    final currentemail = FirebaseAuth.instance.currentUser!.email;

    await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .update({'c': c + 1}); // Increment and update the counter value

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .get();

    setState(() {
      c = snapshot['c'];
    });
  }

  Future<void> _updateTaxCounter() async {
    final currentemail = FirebaseAuth.instance.currentUser!.email;

    await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .update({'d': d + 1}); // Increment and update the counter value

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserCounters')
        .doc(currentemail)
        .get();

    setState(() {
      d = snapshot['d'];
    });
  }

  void _initializeVideoPlayer() {
    _videoPlayerController?.addListener(() {
      if (_videoPlayerController!.value.isInitialized &&
          !_videoPlayerController!.value.isPlaying &&
          _videoPlayerController!.value.position >=
              _videoPlayerController!.value.duration) {
        // Video ended, switch to Lottie animation
        setState(() {
          isPlayingVideo = false;
        });
      }
    });
  }

  Future<void> compressVideo(String inputPath, String email) async {
    final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

    // Define the output path for the compressed video (with a new filename)
    final outputPath =
        'video__${email}_${selected_category?.title}_${selected_category?.title == 'Budgeting' ? a - 1 : selected_category?.title == 'Investing and Saving' ? b - 1 : selected_category?.title == 'Debt Management' ? c - 1 : d - 1}.mp4'; // Replace with your desired path and filename

    final arguments = [
      '-i', inputPath, // Input video file path
      '-vf', 'scale=640:480', // Set the desired resolution (e.g., 640x480)
      '-b:v', '1M', // Set the target video bitrate (adjust as needed)
      outputPath, // Output compressed video file path
    ];

    final result = await _flutterFFmpeg.executeWithArguments(arguments);
    if (result == 0) {
      print('Video compression successful');
    } else {
      print('Video compression failed');
    }
  }

  void videoupload() async {
    final isvalid = _videokey.currentState!.validate();

    final currentemail = FirebaseAuth.instance.currentUser!.email;

    if (!isvalid) {
      return;
    }

    if (videofile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a video to proceed')));

      return;
    }

    if (selected_category?.title == 'Budgeting') {
      await _updateBudgetCounter();
    }
    if (selected_category?.title == 'Investing and Saving') {
      await _updateInvestCounter();
    }
    if (selected_category?.title == 'Debt Management') {
      await _updateDebtCounter();
    }
    if (selected_category?.title == 'Tax Planning') {
      await _updateTaxCounter();
    }

    final budgetvideoFilename =
        'video__${currentemail}_${selected_category?.title}_${selected_category?.title == 'Budgeting' ? a - 1 : selected_category?.title == 'Investing and Saving' ? b - 1 : selected_category?.title == 'Debt Management' ? c - 1 : d - 1}.mp4';

    await compressVideo(budgetvideoFilename, currentemail!);

    final videosReference = await FirebaseStorage.instance
        .ref()
        .child(currentemail)
        .child('videos')
        .child(selected_category!.title)
        .child(budgetvideoFilename);

    await FirebaseFirestore.instance
        .collection(selected_category!.title)
        .doc(currentemail)
        .set({'email': currentemail});

    UploadTask uploadTask = videosReference.putFile(videofile!);

    setState(() {
      isaddingvideo = true;
    });

    await uploadTask.whenComplete(() async {
      final videoUrl = await videosReference.getDownloadURL();

      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      _videoPlayerController?.pause();

      _videoPlayerController?.setVolume(0);

      setState(() {
        isaddingvideo = false;
      });

      print('Video uploaded. URL: $videoUrl');

      print(selected_category!.title);
    });
  }

  void pickvideocam() async {
    final video = await ImagePicker().pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(minutes: 60));

    if (video == null) {
      return;
    }

    setState(() {
      videofile = File(video.path);
      _videoPlayerController?.dispose();
      _videoPlayerController = VideoPlayerController.file(videofile!)
        ..initialize().then((_) {
          setState(() {
            isPlayingVideo = true; // Start playing the video
          });
        });
    });
  }

  void pickvideogall() async {
    final video = await ImagePicker().pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(minutes: 60));

    if (video == null) {
      return;
    }

    setState(() {
      videofile = File(video.path);
      _videoPlayerController?.dispose();
      _videoPlayerController = VideoPlayerController.file(videofile!)
        ..initialize().then((_) {
          setState(() {
            isPlayingVideo = true; // Start playing the video
          });
        });
    });
  }

  @override
  void dispose() {
    videotitlecontroller.dispose();
    videodesccontroller.dispose();
    // _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:
            // IconButton(onPressed: back, icon: Icon(Icons.arrow_back_rounded)),
            Row(
          children: [
            SizedBox(
              width: 6,
            ),
            GestureDetector(
                onTap: back,
                child: Neubox2(child: Icon(Icons.arrow_back_rounded))),
          ],
        ),
        title: Row(
          children: [
            SizedBox(
              width: 32,
            ),
            Text(
              'Upload a video',
              style: namestyle5(),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                width: 300,
                child: isPlayingVideo
                    ? Container(
                        padding: const EdgeInsets.all(15),
                        child: Chewie(
                          controller: ChewieController(
                            videoPlayerController: _videoPlayerController!,
                            autoPlay: true,
                            looping: true,
                          ),
                        ),
                      )
                    : const Text(''),
              ),
              ElevatedButton.icon(
                onPressed: pickvideocam,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Theme.of(context).colorScheme.primaryContainer),
                  elevation: const MaterialStatePropertyAll<double>(3),
                ),
                icon: Container(
                  height: 30,
                  width: 30,
                  child: Lottie.asset('lib/animations/vid.json'),
                ),
                label: Text(
                  'Use Camera',
                  style: namestyle1(),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              ElevatedButton.icon(
                onPressed: pickvideogall,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Theme.of(context).colorScheme.primaryContainer),
                  splashFactory: NoSplash.splashFactory,
                  elevation: const MaterialStatePropertyAll<double>(3),
                ),
                icon: Container(
                  height: 40,
                  width: 40,
                  child: Lottie.asset('lib/animations/vidgall.json'),
                ),
                label: Text(
                  'Pick from gallery',
                  style: namestyle1(),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(15),
                // color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Form(
                          key: _videokey,
                          child: Column(
                            children: [
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  labelText: 'Video Category',
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  errorStyle:
                                      const TextStyle(color: Colors.red),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 40,
                                    minHeight: 40,
                                  ),
                                ),
                                value: selected_category,
                                items: [
                                  for (final cat in vidcategories.entries)
                                    DropdownMenuItem(
                                      value: cat.value,
                                      child: Text(cat.value.title),
                                    )
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selected_category = value!;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: videotitlecontroller,
                                decoration: InputDecoration(
                                  labelText: 'Add Video Title',
                                  labelStyle: namestyle4(),
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      size: 14,
                                      color: Color.fromARGB(255, 55, 54, 54),
                                    ),
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        videotitlecontroller.clear();
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "You can't keep this field blank";
                                  }
                                  return null;
                                },
                                autocorrect: true,
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.multiline,
                                keyboardAppearance: Brightness.dark,
                                onSaved: (newValue) {
                                  entered_video_title = newValue!;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                minLines: 1,
                                maxLines: 10,
                                controller: videodesccontroller,
                                decoration: InputDecoration(
                                  labelText: 'Add Video Description',
                                  labelStyle: namestyle4(),
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      size: 14,
                                      color: Color.fromARGB(255, 55, 54, 54),
                                    ),
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        videodesccontroller.clear();
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "You can't keep this field blank";
                                  }
                                  return null;
                                },
                                autocorrect: true,
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.multiline,
                                keyboardAppearance: Brightness.dark,
                                onSaved: (newValue) {
                                  entered_video_description = newValue!;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: isaddingvideo
                    ? const CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : ElevatedButton.icon(
                        onPressed: videoupload,
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.all(9),
                        ),
                        label: const Text(
                          'Add the video',
                          style: TextStyle(color: Colors.white),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
