import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:peeker/controller/comment_controller.dart';
import 'package:peeker/utils/color_manager.dart';
import 'package:peeker/utils/const.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: ColorManager.primaryColor,
                          backgroundImage: NetworkImage(comment.profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(
                              "${comment.name} ",
                              style: TextStyle(
                                fontSize: 20,
                                color: ColorManager.red,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                comment.comment,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              timeago.format(
                                comment.datePublished.toDate(),
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorManager.white,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              '${comment.likes.length} likes',
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorManager.white,
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () =>
                              commentController.likeComment(comment.id),
                          child: Icon(
                            Icons.favorite,
                            size: 25,
                            color:
                                comment.likes.contains(authController.user.uid)
                                    ? ColorManager.red
                                    : ColorManager.white,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorManager.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Comment ',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorManager.secondaryColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorManager.secondaryColor)),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () =>
                      commentController.postComment(_commentController.text),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
