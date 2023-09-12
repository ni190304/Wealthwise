import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

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
    return GoogleFonts.zeyada(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 60,
        fontWeight: FontWeight.normal,
        // fontStyle: FontStyle.italic
      ),
    );
  }

  File? user_image_file;
  
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
                  padding: const EdgeInsets.only(bottom: 60.0),
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
                            key: _formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  focusNode: _emailnode,
                                  controller: _email_controller,
                                  style: namestyle4(),
                                  decoration: InputDecoration(
                                      labelText: 'Email',labelStyle: namestyle5()
                                      ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
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
                                              : Icons.visibility_off)),),
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
                            )),
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
                        if (!_isAuthenticating)
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
                            child: Text(_isLogin
                                ? 'Create an account'
                                : 'I already have an account. Log in instead'),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
