import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/app-theme.dart';
import 'package:flutter_app_starter_template/util/date-util.dart';
import 'animated-view.dart';
import 'chat-user.dart';

class ChatTextRow extends StatelessWidget
{
  final bool unread;
  final bool isLastOfGroup;
  final bool isOwn;
  final bool isImage;
  final String text;
  final String imageUrl;
  final DateTime date;
  final ChatUser user;
  final int prevMessageOwnerId;
  final AnimationController animationController;
  final Animation animation;

  const ChatTextRow({
    Key key,
    this.unread,
    this.isLastOfGroup,
    this.isOwn,
    this.isImage,
    this.text,
    this.imageUrl,
    @required this.date,
    this.user,
    this.prevMessageOwnerId,
    this.animationController,
    this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    EdgeInsets padding = const EdgeInsets.all(4);

    return AnimatedView(
      animationController: animationController,
      animation: animation,
      child: Padding(
        padding: padding,
        child: _getChild(),
      ),
    );
  }

  Widget _getChild()
  {
    return isOwn ? _buildRightContainer() : _buildLeftContainer();
  }

  Widget _buildTextRow()
  {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          color: isOwn ? AppTheme.chatPrimary : AppTheme.white,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      width: 200.0, // FIXME: Can this container be variable width?
      decoration: BoxDecoration(
        color: isOwn ? AppTheme.chatLightGrey : AppTheme.chatPrimary,
        borderRadius: BorderRadius.circular(8.0)
      ),
    );
  }

  Widget _buildImageRow()
  {
    final double imageSize = 200.0;

    return Container(
      child: GestureDetector(
        onTap: () {
//          Navigator.push(context, MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
        },
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            placeholder: (context, url) => Container(
              width: imageSize,
              height: imageSize,
              padding: EdgeInsets.all(70.0),
              decoration: BoxDecoration(
                color: AppTheme.chatLightGrey,
              ),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              child: Image.asset(
                'images/no-image-available.png',
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileIcon()
  {
    final double iconSize = 35.0;

    if (prevMessageOwnerId == user.id && !isLastOfGroup) {
      return Container(
        margin: const EdgeInsets.only(left: 4, right: 8),
        child: SizedBox(width: iconSize, height: iconSize),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 4, right: 8),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.all(
          Radius.circular(18.0),
        ),
        child: CachedNetworkImage(
          imageUrl: user.profileImageUrl,
          width: iconSize,
          height: iconSize,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: iconSize,
            height: iconSize,
            padding: EdgeInsets.all(10.0),
            child: CircularProgressIndicator(
              strokeWidth: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
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
    );
  }

  Widget _buildMetaInfo()
  {
    final crossAxis = isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: crossAxis,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0),
              child: Text(
                isOwn && !unread ? '既読' : '',
                style: TextStyle(
                  color: AppTheme.chatGrey,
                  fontSize: 9,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
              child: Text(
                DateUtil.dateFormat(date, format: 'HH:mm'),
                style: TextStyle(
                    color: AppTheme.chatGrey,
                    fontSize: 9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightContainer()
  {
    return Container(
      child: IntrinsicHeight( /// <= Important.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Meta information
            _buildMetaInfo(),

            !isImage
            // Text
            ? _buildTextRow()
            // Image
            : _buildImageRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftContainer()
  {
    return Container(
      child: IntrinsicHeight( /// <= Important.
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // Profile image icon
            _buildProfileIcon(),

            !isImage
            // Text
            ? _buildTextRow()
            // Image
            : _buildImageRow(),

            // Meta information
            _buildMetaInfo(),
          ],
        ),
      ),
    );
  }
}
