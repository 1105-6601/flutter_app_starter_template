import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_starter_template/parts/view/chat-user.dart';
import 'package:flutter_app_starter_template/parts/view/content-view.dart';
import 'package:flutter_app_starter_template/util/date-util.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import 'animated-view.dart';
import '../../app-theme.dart';

class ChatUserRow extends StatelessWidget
{
  final AnimationController animationController;
  final Animation animation;
  final ChatUser chatUser;
  final VoidCallback onTap;

  ChatUserRow({
    Key key,
    this.animationController,
    this.animation,
    this.chatUser,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return AnimatedView(
      animationController: animationController,
      animation: animation,
      child: getChild(),
    );
  }

  Widget getChild()
  {
    return ContentView(
      animationController: animationController,
      animation: UiUtil.createAnimation(animationController, 0),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 8),
      paddingInner: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      borderRadius: const BorderRadius.only(
        topLeft:     const Radius.circular(8.0),
        bottomLeft:  const Radius.circular(8.0),
        bottomRight: const Radius.circular(8.0),
        topRight:    const Radius.circular(34.0)
      ),
      content: getContent(),
      onTap: onTap
    );
  }

  Widget getContent()
  {
    BoxDecoration unreadDecoration = const BoxDecoration();
    String unreadText = '';
    double iconRadius = 24.0;
    double iconSize = 48.0;

    if (chatUser.unreadCount != null && chatUser.unreadCount != 0) {
      unreadDecoration = BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.darkRed,
      );

      unreadText = '${chatUser.unreadCount}';
    }

    return Row(
      children: <Widget>[

        // Left part
        Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.all(
            Radius.circular(iconRadius),
          ),
          child: CachedNetworkImage(
            imageUrl: chatUser.profileImageUrl,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: iconSize,
              height: iconSize,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppTheme.chatLightGrey,
              ),
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.grey),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              child: Image.asset(
                'images/no-image-g.png',
                width: iconSize,
                height: iconSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Center part
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  chatUser.name,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.shadowC
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    chatUser.preview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.shadow6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Right part
        Padding(
          padding: const EdgeInsets.only(left: 6, right: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                DateUtil.elapsedTime(chatUser.date),
                style: TextStyle(
                  fontSize: 7,
                  color: AppTheme.shadowC
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: unreadDecoration,
                  child: Center(
                    child: Text(
                      unreadText,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
