import 'package:flutter/material.dart';
import 'package:wealthwise/neubox.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: const Center(
          child: NeuBox(
        child: Icon(
          Icons.abc_rounded,
          color: Colors.black,
          size: 35,
        ),
      )),
    );
  }
}
