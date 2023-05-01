import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:peeker/models/video.dart';
import 'package:peeker/utils/const.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = fAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage('Videos $len', videoPath);
      String thumbnail = await _uploadImageToStorage('Videos $len', videoPath);

      Video video = Video(
        name: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: 'Video $len',
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto:
            (userDoc.data()! as Map<String, dynamic>)['profilePicture'],
        likes: [],
        commentCount: 0,
        shareCount: 0,
      );

      await firestore
          .collection('videos')
          .doc('Video $len')
          .set(video.toJson());

      Get.back();
      Get.snackbar(
          'Uploaded Successfully', 'Video has been uploaded successfully');
    } catch (e) {
      Get.snackbar('Error Uploading Video', e.toString());
      print(e);
    }
  }
}
