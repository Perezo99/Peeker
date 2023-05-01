import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String name;
  String comment;
  String uid;
  String id;
  String profilePhoto;
  List likes;
  final datePublished;

  Comment({
    required this.name,
    required this.comment,
    required this.uid,
    required this.id,
    required this.profilePhoto,
    required this.likes,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'comment': comment,
        'uid': uid,
        'id': id,
        'profilePhoto': profilePhoto,
        'likes': likes,
        'datePublished': datePublished,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      name: snapshot['name'],
      comment: snapshot['comment'],
      uid: snap['uid'],
      id: snapshot['id'],
      profilePhoto: snapshot['profilePhoto'],
      likes: snapshot['likes'],
      datePublished: snapshot['datePublished'],
    );
  }
}
