import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:peeker/controller/profile_controller.dart';
import 'package:peeker/utils/color_manager.dart';
import 'package:peeker/utils/const.dart';
import 'package:peeker/utils/layout.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              centerTitle: true,
              leading: const Icon(
                Icons.person_add_alt_1_outlined,
              ),
              actions: const [Icon(Icons.more_horiz)],
              title: Text(
                controller.user['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.white,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: controller.user['profilePhoto'],
                                height: Layout.getHeight(100),
                                width: Layout.getWidth(100),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                        const Gap(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.user['following'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.white,
                                  ),
                                ),
                                const Gap(5),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black54,
                              width: Layout.getWidth(1),
                              height: Layout.getHeight(15),
                              margin: EdgeInsets.symmetric(
                                horizontal: Layout.getWidth(15),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.user['followers'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.white,
                                  ),
                                ),
                                const Gap(5),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black54,
                              width: Layout.getWidth(1),
                              height: Layout.getHeight(15),
                              margin: EdgeInsets.symmetric(
                                horizontal: Layout.getWidth(15),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.user['likes'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.white,
                                  ),
                                ),
                                const Gap(5),
                                Text(
                                  'Likes',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(15),
                        Container(
                          width: Layout.getWidth(140),
                          height: Layout.getHeight(47),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                if (widget.uid == authController.user.uid) {
                                  authController.signOut();
                                } else {
                                  controller.followUser();
                                }
                              },
                              child: Text(
                                widget.uid == authController.user.uid
                                    ? 'Sign Out'
                                    : controller.user['isFollowing']
                                        ? 'Unfollow'
                                        : 'Follow',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(25),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.user['thumbnails'].length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            String thumbnail =
                                controller.user['thumbnails'][index];
                            return CachedNetworkImage(
                              imageUrl: thumbnail,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
