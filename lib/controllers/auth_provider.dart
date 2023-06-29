import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:the_test_naruto_arena/controllers/routing/app_pages.dart';

import '../keys.dart';
import '../models/user.dart';
import '../widgets/custom_text_field.dart';

class AuthProviderController extends GetxController {
  Rx<UserProfile> userProfile = UserProfile.getEmpty().obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  late Stream<User?> snapshots;
  late StreamSubscription<User?> listner;
  var box = Hive.box('credentials');
  Timer? _timer;
  AuthType _authType = AuthType.signIn;
  AuthType get authType => _authType;
  RxBool userAuth = false.obs;
  RxBool saveInPref = false.obs;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    getFillLoginFields();
    runAuthStream();
    super.onInit();
  }

  void onClose() async {
    listner.cancel();
    _timer?.cancel();
    super.onClose();
  }

  setAuthType() {
    _authType =
        _authType == AuthType.signIn ? AuthType.signUp : AuthType.signIn;
    update();
  }

  void getFillLoginFields() async {
    emailController.text = box.get('email')?? '';
    passwordController.text = box.get('password')?? '';
  }

  void runAuthStream() async {
    snapshots = FirebaseAuth.instance.authStateChanges();
    listner = snapshots.listen(
      (user) {
        if (user != null) {
          userAuth.value = true;
          setProfile(user.uid);
        } else {
          userAuth.value = false;
        }
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  authenticate() async {
    UserCredential userCredential;
    if (saveInPref.value) {
      box.put('email', emailController.text);
      box.put('password', passwordController.text);
    }

    try {
      if (_authType == AuthType.signUp) {
        userCredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await userCredential.user!.sendEmailVerification();
        await firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': userCredential.user!.email,
          'uid': userCredential.user!.uid,
          'userName': userNameController.text,
        });
      }
      if (_authType == AuthType.signIn) {
        userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      }
      Get.toNamed(Routes.INITIAL);
    } on FirebaseAuthException catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.code),
        backgroundColor: Colors.red,
      ));
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  bool? emailVerified;
  updateEmailVerification() async {
    emailVerified = firebaseAuth.currentUser!.emailVerified;

    if (!emailVerified!) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        print('timer called');
        await firebaseAuth.currentUser!.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          emailVerified = user.emailVerified;
          _timer!.cancel();
        }
      });
    }
  }

  void setProfile(String uid) async {
    userProfile.value = await getUserProfile(uid);
    update();
  }

  Future<UserProfile> getUserProfile(String uid) async {
    var doc = await firebaseFirestore.collection('users').doc(uid).get();
    if (doc.exists) {
      var data = doc.data();
      return UserProfile(
          isLoaded: true,
          uid: data!['uid'],
          email: data['email'],
          userName: data['userName']);
    }
    return UserProfile.getEmpty();
  }

  TextEditingController resetEmailController = TextEditingController();
  resetPassword(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Enter your email'),
            content: CustomTextField(
              iconData: Icons.email,
              hintText: 'Enter email',
              controller: resetEmailController,
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context).pop();
                    try {
                      await firebaseAuth.sendPasswordResetEmail(
                          email: resetEmailController.text);
                      Keys.scaffoldMessengerKey.currentState!
                          .showSnackBar(const SnackBar(
                        content: Text('Email sent succesfuly'),
                        backgroundColor: Colors.green,
                      ));
                      navigator;
                    } catch (error) {
                      Keys.scaffoldMessengerKey.currentState!
                          .showSnackBar(SnackBar(
                        content: Text(error.toString()),
                        backgroundColor: Colors.red,
                      ));
                      navigator;
                    }
                  },
                  child: const Text('Submit'))
            ],
          );
        });
  }

  GoogleSignIn googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await firebaseAuth.signInWithCredential(authCredential);
        print(googleSignInAccount.photoUrl);
        print(googleSignInAccount.displayName);
        print(googleSignInAccount.email);
      } on FirebaseAuthException catch (e) {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text('Account not selected'),
        backgroundColor: Colors.red,
      ));
    }
  }

  logOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      _timer?.cancel();
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
}

enum AuthType { signIn, signUp }
