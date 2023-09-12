import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:video_player/video_player.dart';
// import 'package:wealthwise/first_screen.dart';
import 'package:wealthwise/firebase_options.dart';
import 'package:wealthwise/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',

    androidProvider: AndroidProvider.debug,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MiniProject());
}

class MiniProject extends StatelessWidget {
  const MiniProject({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Start());
  }
}


class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
   late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network('https://firebasestorage.googleapis.com/v0/b/wealthwise-739c2.appspot.com/o/tutor1%40gmail.com%2Fvideos%2FBudgeting%2Fvideo__tutor1%40gmail.com_Budgeting_1.mp4?alt=media&token=c1831bfb-c667-4a38-8790-696f417e4f92')
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }
  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  final videos = ["https://firebasestorage.googleapis.com/v0/b/wealthwise-739c2.appspot.com/o/tutor1%40gmail.com%2Fvideos%2FBudgeting%2Fvideo__tutor1%40gmail.com_Budgeting_1.mp4?alt=media&token=c1831bfb-c667-4a38-8790-696f417e4f92", "https://firebasestorage.googleapis.com/v0/b/wealthwise-739c2.appspot.com/o/tutor1%40gmail.com%2Fvideos%2FBudgeting%2Fvideo__tutor1%40gmail.com_Budgeting_2.mp4?alt=media&token=300ca511-c229-4b7f-861e-5f7630f37106"," https://firebasestorage.googleapis.com/v0/b/wealthwise-739c2.appspot.com/o/tutor1%40gmail.com%2Fvideos%2FBudgeting%2Fvideo__tutor1%40gmail.com_Budgeting_3.mp4?alt=media&token=0ce2c6e7-5555-4a3e-8569-016192a43252"];

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: videos.map((e) => Material(child: VideoPlay(pathh: e,))).toList())

      )
    );
  }
}

class VideoPlay extends StatefulWidget {
  String pathh;

  @override
  _VideoPlayState createState() => _VideoPlayState();

  VideoPlay({
    Key? key,
   required this.pathh, 
  }) : super(key: key);
}

class _VideoPlayState extends State<VideoPlay> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;

  initVideo() {
    controller = VideoPlayerController.network(widget.pathh);

    futureController = controller!.initialize();
  }

  @override
  void initState() {
    initVideo();
    controller!.addListener(() {
      if (controller!.value.isInitialized) {
        currentPosition.value = controller!.value;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              height: controller!.value.size.height,
              width: double.infinity,
              child: AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: Stack(children: [
                    Positioned.fill(
                        child: Container(
                            foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(.7),
                                    Colors.transparent
                                  ],
                                  stops: [
                                    0,
                                    .3
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                            child: VideoPlayer(controller!))),
                    Positioned.fill(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onDoubleTap: () async {
                                      Duration? position =
                                          await controller!.position;
                                      setState(() {
                                        controller!.seekTo(Duration(
                                            seconds: position!.inSeconds - 10));
                                      });
                                    },
                                    child: const Icon(
                                      Icons.fast_rewind_rounded,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: IconButton(
                                      icon: Icon(
                                        controller!.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (controller!.value.isPlaying) {
                                            controller!.pause();
                                          } else {
                                            controller!.play();
                                          }
                                        });
                                      },
                                    )),
                                Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onDoubleTap: () async {
                                      Duration? position =
                                          await controller!.position;
                                      setState(() {
                                        controller!.seekTo(Duration(
                                            seconds: position!.inSeconds + 10));
                                      });
                                    },
                                    child: const Icon(
                                      Icons.fast_forward_rounded,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ValueListenableBuilder(
                                    valueListenable: currentPosition,
                                    builder: (context,
                                        VideoPlayerValue? videoPlayerValue, w) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              videoPlayerValue!.position
                                                  .toString()
                                                  .substring(
                                                      videoPlayerValue.position
                                                              .toString()
                                                              .indexOf(':') +
                                                          1,
                                                      videoPlayerValue.position
                                                          .toString()
                                                          .indexOf('.')),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22),
                                            ),
                                            const Spacer(),
                                            Text(
                                              videoPlayerValue.duration
                                                  .toString()
                                                  .substring(
                                                      videoPlayerValue.duration
                                                              .toString()
                                                              .indexOf(':') +
                                                          1,
                                                      videoPlayerValue.duration
                                                          .toString()
                                                          .indexOf('.')),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ))
                        ],
                      ),
                    ),
                  ])),
            ),
          );
        }
      },
    );
  }
}