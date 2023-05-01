import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peeker/models/user.dart';
import 'package:peeker/utils/color_manager.dart';
import 'package:peeker/views/Profile/profile_screen.dart';

import '../../controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchController _searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.red,
          title: TextFormField(
            decoration: InputDecoration(
              filled: false,
              hintText: 'Search ',
              hintStyle: TextStyle(
                fontSize: 18,
                color: ColorManager.white,
              ),
            ),
            onFieldSubmitted: (value) => _searchController.searchUser(value),
          ),
        ),
        body: _searchController.searchedUsers.isEmpty
            ? Center(
                child: Text(
                  'Search for users',
                  style: TextStyle(
                    fontSize: 25,
                    color: ColorManager.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: _searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  UserM user = _searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(uid: user.uid),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePicture),
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
