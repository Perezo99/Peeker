import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:peeker/controller/auth_controller.dart';
import 'package:peeker/views/Profile/profile_screen.dart';
import 'package:peeker/views/Search/search_screen.dart';
import 'package:peeker/views/video_player/video_player.dart';

import '../views/add_video/add_video_screen.dart';

var fAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;
var authController = AuthController.instance;

List pages = [
  VideoPlayer(),
  SearchScreen(),
  const AddVideo(),
  Text('Message Screen'),
  ProfileScreen(uid: authController.user.uid),
];
