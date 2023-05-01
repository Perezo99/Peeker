import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:peeker/models/user.dart';
import 'package:peeker/utils/const.dart';

class SearchController extends GetxController {
  final Rx<List<UserM>> _searchedUsers = Rx<List<UserM>>([]);

  List<UserM> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserM> retVal = [];
      for (var e in query.docs) {
        retVal.add(UserM.fromSnap(e));
      }
      return retVal;
    }));
  }
}
