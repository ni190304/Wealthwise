import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wealthwise/neubox1.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

TextStyle namestyle1() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle2() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 13, 1, 98),
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle4() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
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

class _AuthScreenState extends State<AuthScreen> {
  TextStyle namestyle3() {
    return GoogleFonts.passionsConflict(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 85,
        fontWeight: FontWeight.normal,
        // fontStyle: FontStyle.italic
      ),
    );
  }

  File? user_image_file;
  String? userProfilePic;
  String? user_email;

  Color color = Colors.white;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      userProfilePic = user!.photoURL; // Get the user's profile picture URL
      user_email = user.email;
      final em = FirebaseAuth.instance.currentUser!.email;

      print(userProfilePic);
      print(user_email);
      print(em);

      // Check if the user has a profile picture URL
      if (userProfilePic != null) {
        final userImagesRef = FirebaseStorage.instance
            .ref()
            .child(em!)
            .child('profile') // Use user's email as the folder name
            .child('$em.jpg'); // Use a fixed name for the profile picture

        // Upload the user's profile picture to Firebase Storage
        // You can use the URL directly, as it's provided by Google sign-in
        await userImagesRef.putData(
            (await NetworkAssetBundle(Uri.parse(userProfilePic!)).load(''))
                .buffer
                .asUint8List());

        // Store the download URL in Firestore or wherever you need it
        // For example, you can update the user's profile with the URL
        await FirebaseFirestore.instance.collection('Usernames').doc(em).set({
          'username': user.displayName,
        });

        await FirebaseFirestore.instance
            .collection('ColorMode')
            .doc(em)
            .set({'color': color.toString()});
      }

      return user;
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }

  void pickImagecam() async {
    final userImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 150, imageQuality: 80);

    if (userImage == null) {
      return;
    }

    setState(() {
      user_image_file = File(userImage.path);
    });
  }

  void pickImagegall() async {
    final userImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 150, imageQuality: 80);

    if (userImage == null) {
      return;
    }

    setState(() {
      user_image_file = File(userImage.path);
    });
  }

  var _isLogin = true;

  var _isvalid = false;

  var validity;

  var is_img_sel = false;

  var _isAuthenticating = false;

  var entered_email = '';
  var entered_user = '';
  var entered_pass = '';

  bool visibility_off = true;

  final _emailnode = FocusNode();

  // bool _is_val = true;

  final _email_controller = TextEditingController();
  final _username_controller = TextEditingController();
  final _password_controller = TextEditingController();

  @override
  void dispose() {
    _email_controller.dispose();
    _username_controller.dispose();
    _password_controller.dispose();
    _emailnode.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();

  void submitDetails() async {
    // final email = FirebaseAuth.instance.currentUser!.email;
    final _isvalid = _formkey.currentState!.validate();

    if (!_isvalid) {
      return;
    }

    setState(() {
      validity = _isvalid;
    });

    if (user_image_file == null && !_isLogin) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image to proceed')),
      );

      return;
    }

    _formkey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final UserCredential userCred =
            await _firebase.signInWithEmailAndPassword(
          email: entered_email,
          password: entered_pass,
        );
        // print(userCred);
      } else {
        final UserCredential userCred =
            await _firebase.createUserWithEmailAndPassword(
          email: entered_email,
          password: entered_pass,
        );
        // print(userCred);

        final email = FirebaseAuth.instance.currentUser!.email;

        final user_images = FirebaseStorage.instance
            .ref()
            .child(email!)
            .child('profile')
            .child('$email.jpg');

        await FirebaseFirestore.instance
            .collection('Usernames')
            .doc(email)
            .set({'username': entered_user});

        await FirebaseFirestore.instance
            .collection('ColorMode')
            .doc(email)
            .set({'color': color.toString()});

        final upload_task = user_images.putFile(user_image_file!);

        await upload_task.whenComplete(() async {
          final user_img_url = await user_images.getDownloadURL();
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Authentication failed')),
      );

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  void focusEmailfield() {
    if (!_emailnode.hasFocus) {
      FocusScope.of(context).requestFocus(_emailnode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isLogin)
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.black,
                      child: user_image_file != null
                          ? ClipOval(
                              child: Image.file(
                              user_image_file!,
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ))
                          : Lottie.asset('lib/animations/image.json',
                              width: 120, height: 120),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton.icon(
                        onPressed: pickImagecam,
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Theme.of(context).colorScheme.primaryContainer),
                          elevation: const MaterialStatePropertyAll<double>(3),
                        ),
                        icon: Container(
                            height: 40,
                            width: 40,
                            child: Lottie.asset('lib/animations/cam.json')),
                        label: Text(
                          'Use Camera',
                          style: namestyle1(),
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                    ElevatedButton.icon(
                        onPressed: pickImagegall,
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Theme.of(context).colorScheme.primaryContainer),
                          splashFactory: NoSplash.splashFactory,
                          elevation: const MaterialStatePropertyAll<double>(3),
                        ),
                        icon: Container(
                            height: 40,
                            width: 40,
                            child: Lottie.asset('lib/animations/gall.json')),
                        label: Text(
                          'Pick from gallery',
                          style: namestyle1(),
                        )),
                  ],
                ),
              if (_isLogin)
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    'Wealthwise',
                    style: namestyle3(),
                  ),
                ),
              Card(
                margin: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Form(
                          // autovalidateMode: _is_val
                          //     ? AutovalidateMode
                          //         .disabled // Show validation errors if _showValidation is true
                          //     : AutovalidateMode
                          //         .always, // Hide validation errors if _showValidation is false
                          key: _formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                // autovalidateMode: AutovalidateMode.onUserInteractio,
                                focusNode: _emailnode,
                                controller: _email_controller,
                                style: namestyle4(),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: namestyle5(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Invalid email';
                                  }
                                  if (RegExp(r'[A-Z]').hasMatch(value)) {
                                    return "Email can't have uppercase letters";
                                  }

                                  if (value.contains(' ')) {
                                    return 'Invalid credentials';
                                  }

                                  return null;
                                },
                                autocorrect: true,
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.emailAddress,
                                keyboardAppearance: Brightness.dark,
                                onSaved: (newValue) {
                                  entered_email = newValue!;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (!_isLogin)
                                TextFormField(
                                  controller: _username_controller,
                                  style: namestyle4(),
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    labelStyle: namestyle5(),
                                  ),
                                  validator: (value) {
                                    if (!RegExp(r'\d').hasMatch(value!)) {
                                      return 'Username must contain a digit';
                                    }
                                    if (value.trim().length < 4) {
                                      return 'Username must contain at least 4 characters';
                                    }

                                    if (RegExp(r'[A-Z]').hasMatch(value)) {
                                      return "Username can't have uppercase letters";
                                    }

                                    if (value.contains(' ')) {
                                      return 'Invalid credentials';
                                    }

                                    return null;
                                  },
                                  autocorrect: true,
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.name,
                                  onSaved: (newValue) {
                                    entered_user = newValue!;
                                  },
                                ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: _password_controller,
                                style: namestyle4(),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: namestyle5(),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        visibility_off = !visibility_off;
                                      });
                                    },
                                    child: Icon(visibility_off
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.trim().length < 6) {
                                    return 'Password must contain at least 6 characters';
                                  }

                                  if (value.contains(' ')) {
                                    return 'Invalid credentials';
                                  }

                                  return null;
                                },
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                obscureText: visibility_off,
                                onSaved: (newValue) {
                                  entered_pass = newValue!;
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        if (_isAuthenticating && validity)
                          const CircularProgressIndicator(),
                        if (!_isAuthenticating)
                          ElevatedButton.icon(
                            onPressed: submitDetails,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(
                                  top: 12, bottom: 12, left: 15, right: 15),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            icon: Icon(
                              _isLogin
                                  ? Icons.login_rounded
                                  : Icons.account_circle,
                              color: Colors.white,
                            ),
                            label: Text(
                              _isLogin ? 'Login' : 'Signup',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        if (!_isAuthenticating && !_isLogin)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                                _email_controller.clear();
                                _username_controller.clear();
                                _password_controller.clear();
                                focusEmailfield();
                                visibility_off = true;
                              });
                            },
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: const Text(
                                'I already have an account. Log in instead'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (_isLogin)
                GestureDetector(
                    onTap: () async {
                      User? user = await signInWithGoogle();
                      if (user != null) {
                        // User signed in successfully
                        // You can navigate to another screen or perform actions here
                        print("User signed in: ${user.displayName}");
                      } else {
                        // Handle sign-in failure or user cancellation
                        print("Sign-in failed");
                      }
                    },
                    child: Neubox2(child: Image.asset('lib/pics/google.jpg'))),
              // const SizedBox(
              //   height: 10,
              // ),
              if (!_isAuthenticating && _isLogin)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                      _email_controller.clear();
                      _username_controller.clear();
                      _password_controller.clear();
                      focusEmailfield();
                      visibility_off = true;
                    });
                  },
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: const Text('I am a new member.Create an account'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
