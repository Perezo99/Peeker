import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peeker/models/user.dart';
import 'package:peeker/utils/const.dart';
import 'package:peeker/utils/route_manager.dart';
import 'package:peeker/views/Home/home.dart';
import 'package:peeker/views/auth/Login/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(fAuth.currentUser);
    _user.bindStream(fAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture', 'Image Added Successfully');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePicture')
        .child(fAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //register user
  void registerUser(
      String name, String email, String password, File? image) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential userCred = await fAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);
        UserM user = UserM(
          name: name,
          email: email,
          profilePicture: downloadUrl,
          uid: userCred.user!.uid,
        );
        await firestore
            .collection('users')
            .doc(userCred.user!.uid)
            .set(user.toJson());

        Get.snackbar('Welcome', 'Successful');
        Get.to(HomeScreen());
      } else {
        Get.snackbar('Something Isnt rigth, please check again!',
            "Please Fill Up All The Fields.");
      }
    } catch (e) {
      Get.snackbar('Something Isnt rigth, please check again!', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await fAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Get.to(HomeScreen());
      } else {
        Get.snackbar(
          'Error Loggin in',
          'Please fill all your information',
        );
      }
    } catch (e) {
      Get.snackbar('Error Loggin in', e.toString());
    }
  }

  void signOut() async {
    await fAuth.signOut();
  }
}
