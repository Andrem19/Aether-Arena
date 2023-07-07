import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';
import 'package:the_test_naruto_arena/controllers/routing/app_pages.dart';
import 'package:the_test_naruto_arena/models/personal_settings.dart';

import '../keys.dart';
import '../models/user.dart';
import '../widgets/custom_text_field.dart';

class AuthProviderController extends GetxController {
  late MainGameController _mainGameController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  late SharedPreferences prefs;
  late Stream<User?> snapshots;
  late StreamSubscription<User?> listner;
  Timer? _timer;
  AuthType _authType = AuthType.signIn;
  AuthType get authType => _authType;
  RxBool userAuth = false.obs;
  RxBool saveInPref = false.obs;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    await getFillLoginFields();
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

  void initialize(MainGameController mainGameController) {
    _mainGameController = mainGameController;
  }

  Future<void> getFillLoginFields() async {
    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
  }

  bool checkAuthentication() {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      print('User is authenticated');
      return true;
    } else {
      print('User is not authenticated');
      return false;
    }
  }

  authenticate() async {
    late UserCredential userCredential;
    if (saveInPref.value) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    }

    try {
      if (_authType == AuthType.signUp) {
        String normalizedName =
            userNameController.text.replaceAll(RegExp(r'\s+'), '');
        bool res = await chekNameExist(normalizedName);
        if (res) {
          return;
        }
        userCredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await userCredential.user!.sendEmailVerification();
        await firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': userCredential.user!.email,
          'uid': userCredential.user!.uid,
          'userName': userNameController.text.replaceAll(RegExp(r'\s+'), ''),
          'personalSettings': PersonalSettings.getDefault().toJson(),
          'mySet': [0, 0, 0],
          'avatar': '',
          'nickWasChanged': 0,
          'expirience': 1,
          'isUserInGame': false,
          'wantToPlay': true,
          'blackList': [],
        });
        _mainGameController.userProfile.value.uid = userCredential.user!.uid;
        await firebaseFirestore
            .collection('history')
            .doc(userCredential.user!.uid)
            .set({
          'myHistory': [],
          'uid': userCredential.user!.uid,
        });
        createMeetPoint(userCredential.user!.uid);
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text(
              'Please verify your email, and then you can login with your credentials'),
          backgroundColor: Colors.green,
        ));
        await firebaseAuth.signOut();
        _authType = AuthType.signIn;
        update();
      } else if (_authType == AuthType.signIn) {
        userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        if (userCredential.user!.emailVerified) {
          userAuth.value = true;
          await setProfile(userCredential.user!.uid);
          await _mainGameController.getHistory();
          update();
          Get.offAllNamed(Routes.INITIAL);
        } else {
          Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
            content: Text(
                'Please verify your email, and then you can login with your credentials'),
            backgroundColor: Colors.green,
          ));
        }
      }
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

  void createMeetPoint(String uid) async {
    await firebaseFirestore.collection('meetPoint').doc(uid).set({
      'isAnybodyAscMe': false,
      'whoInviteMeToPlay': '',
      'theGameIdInviteMe': '',
    });
  }

  Future<bool> chekNameExist(String name) async {
    try {
      var doc = await firebaseFirestore
          .collection('users')
          .where('userName', isEqualTo: name)
          .get();
      if (doc.docs.length > 0) {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text('This name exist. Create another name'),
          backgroundColor: Colors.red,
        ));
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (error) {
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
    return false;
  }

  Future<void> setProfile(String uid) async {
    UserProfile user = await getUserProfile(uid);
    _mainGameController.userProfile.value = user;
    _mainGameController.getLevel();
    _mainGameController.update();
  }

  Future<UserProfile> getUserProfile(String uid) async {
    var doc = await firebaseFirestore.collection('users').doc(uid).get();
    if (doc.exists) {
      var data = doc.data();

      return UserProfile(
        isLoaded: true,
        uid: data!['uid'],
        email: data['email'],
        userName: data['userName'],
        personalSettings: PersonalSettings.fromJson(data['personalSettings']),
        mySet: (data['mySet'] as List<dynamic>)
            .map((card) => int.parse(card.toString()))
            .toList(),
        avatar: data['avatar'],
        nickWasChanged: data['nickWasChanged'],
        expirience: data['expirience'],
        isUserInGame: data['isUserInGame'],
        wantToPlay: data['wantToPlay'],
      );
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
      // await googleSignIn.signOut();
      _timer?.cancel();
      userAuth.value = false;
      Get.offAllNamed(Routes.INITIAL);
      update();
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
}

enum AuthType { signIn, signUp }
