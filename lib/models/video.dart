import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String name;
  String uid;
  String id;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;
  List likes;
  int commentCount;
  int shareCount;

  Video({
    required this.name,
    required this.uid,
    required this.id,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'id': id,
        'songName': songName,
        'caption': caption,
        'videoUrl': videoUrl,
        'thumbnail': thumbnail,
        'profilePhoto': profilePhoto,
        'likes': likes,
        'commentCount': commentCount,
        'shareCount': shareCount
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      name: snapshot['name'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      songName: snapshot['songName'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      thumbnail: snapshot['thumbnail'],
      profilePhoto: snapshot['profilePhoto'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
    );
  }
}
