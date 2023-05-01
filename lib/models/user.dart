import 'package:cloud_firestore/cloud_firestore.dart';

class UserM {
  String name;
  String email;
  String profilePicture;
  String uid;

  UserM({
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profilePicture": profilePicture,
        "uid": uid,
      };

  static UserM fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserM(
      name: snapshot['name'],
      email: snapshot['email'],
      profilePicture: snapshot['profilePicture'],
      uid: snapshot['uid'],
    );
  }
}
