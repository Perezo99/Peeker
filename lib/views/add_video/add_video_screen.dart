import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peeker/utils/color_manager.dart';
import 'package:peeker/utils/route_manager.dart';
import 'package:peeker/views/add_video/widgets/confirm_screen.dart';

import '../../utils/layout.dart';

class AddVideo extends StatelessWidget {
  const AddVideo({super.key});

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConfirmScreen(
              videoFile: File(video.path), videoPath: video.path)));
    }
  }

  showODialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          ' Camera',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          ' Gallery',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(Icons.cancel),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          ' Cancel',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showODialog(context),
          child: Container(
            width: Layout.getWidth(190),
            height: Layout.getHeight(50),
            decoration: BoxDecoration(color: ColorManager.secondaryColor),
            child: Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 20,
                  color: ColorManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
