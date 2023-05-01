import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:peeker/controller/upload_video_controller.dart';
import 'package:peeker/utils/color_manager.dart';
import 'package:peeker/utils/layout.dart';
import 'package:peeker/views/widgets/custom_button.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController _controller;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  final UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = VideoPlayerController.file(widget.videoFile);
    });
    _controller.initialize();
    _controller.play();
    _controller.setVolume(1);
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(
              Layout.getHeight(30),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: Layout.getHeight(400),
              child: VideoPlayer(_controller),
            ),
            Gap(
              Layout.getHeight(30),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: Layout.getWidth(10)),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextField(
                      controller: _songController,
                      style: TextStyle(color: ColorManager.white),
                      decoration: InputDecoration(
                        labelText: 'Song Name',
                        labelStyle: TextStyle(color: ColorManager.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: ColorManager.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: ColorManager.secondaryColor, width: 2.0),
                        ),
                        icon: Icon(
                          Icons.music_note,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                  Gap(Layout.getHeight(10)),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: Layout.getWidth(10)),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextField(
                      controller: _captionController,
                      style: TextStyle(color: ColorManager.white),
                      cursorColor: ColorManager.white,
                      decoration: InputDecoration(
                        labelText: 'Caption',
                        labelStyle: TextStyle(color: ColorManager.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: ColorManager.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: ColorManager.secondaryColor, width: 2.0),
                        ),
                        icon: Icon(
                          Icons.closed_caption,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  Container(
                      width: Layout.getWidth(230),
                      child: CustomButton(
                        () => uploadVideoController.uploadVideo(
                          _songController.text,
                          _captionController.text,
                          widget.videoPath,
                        ),
                        'Share',
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
