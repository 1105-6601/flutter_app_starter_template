import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/entity/message.dart';
import 'package:flutter_app_starter_template/pages/base-tab.dart';
import 'package:flutter_app_starter_template/pages/tab3/tab3.dart';
import 'package:flutter_app_starter_template/parts/view/chat-user.dart';
import 'package:flutter_app_starter_template/util/date-util.dart';
import 'package:flutter_app_starter_template/util/mock-util.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import 'chat-text-group.dart';
import 'chat-text-row.dart';
import '../../app-theme.dart';

class ChatDetailView extends BaseTab
{
  final AnimationController animationController;
  final Function(Widget widget) changeTabBody;
  final ChatUser chatUser;

  const ChatDetailView({
    Key key,
    this.animationController,
    this.changeTabBody,
    this.chatUser,
  }) : super.chat(
    key: key,
    animationController: animationController,
    changeTabBody: changeTabBody,
    showBackLink: true,
  );

  @override
  String getTitle()
  {
    return chatUser.name;
  }

  @override
  String resolveIconImageAsUrl()
  {
    return chatUser.profileImageUrl;
  }

  @protected
  void onBackLinkTap()
  {
    changeTabBody(Tab3(
      animationController: animationController,
      changeTabBody: changeTabBody,
    ));
  }

  @protected
  Future<List<Message>> initMessages() async
  {
    // FIXME: Get valid self user data.
    final selfUser = ChatUser.generateMockSelf();
    final messages = Message.generateDummyMessages([chatUser, selfUser]);

    return messages;
  }

  @protected
  Future<void> loadPastMessages(DateTime before, BaseTabState state) async
  {
    // FIXME: Get valid self user data.
    final selfUser = ChatUser.generateMockSelf();
    final messages = Message.generateDummyMessages([chatUser, selfUser], before: before);

    state.addMessages(messages);
  }

  @protected
  List<ChatTextGroup> buildMessageGroups(List<Message> messages)
  {
    // FIXME: Get valid self user data.
    final selfUser = ChatUser.generateMockSelf();

    bool unread = true;

    List<ChatTextGroup> groups = [];
    List<ChatTextRow> rows = [];
    String currentDateLabel;

    messages.asMap().forEach((index, message) {

      final int nextIndex = index + 1;
      Message prevMessage = messages.asMap().containsKey(nextIndex) ? messages[nextIndex] : null;

      if (unread && MockUtil.select(threshold: 0.95)) {
        unread = false;
      }

      if (currentDateLabel == null) {
        currentDateLabel = DateUtil.dateFormat(message.date, format: 'MM/dd(E)');
      }

      final isLastOfGroup = prevMessage != null && DateUtil.dateFormat(message.date) != DateUtil.dateFormat(prevMessage.date);

      rows.add(ChatTextRow(
        unread:              unread,
        isLastOfGroup:       isLastOfGroup,
        text:                '${message.text} ($index)',
        isOwn:               message.user.id == selfUser.id,
        isImage:             message.isImage,
        imageUrl:            message.imageUrl,
        date:                message.date,
        user:                message.user,
        prevMessageOwnerId:  prevMessage != null ? prevMessage.user.id : null,
        animationController: animationController,
        animation:           UiUtil.createAnimation(animationController, 0),
      ));

      if (isLastOfGroup) {

        groups.add(ChatTextGroup(
          dateLabel: currentDateLabel,
          rows: rows,
        ));

        // Clear rows cache
        rows = [];
        // Change date label
        currentDateLabel = DateUtil.dateFormat(prevMessage.date, format: 'MM/dd(E)');
      }
    });

    return groups;
  }

  @protected
  Widget buildChatInputControlBar()
  {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppTheme.chatLightGrey,
            width: 0.5
          )
        ),
      ),
      child: Row(
        children: <Widget>[

          // Image button
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: () {
                },
                color: AppTheme.chatPrimary,
              ),
            ),
            color: Colors.white,
          ),

          // Stamp button
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.tag_faces),
                onPressed: () {
                },
                color: AppTheme.chatPrimary,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(
                    color: AppTheme.chatPrimary,
                    fontSize: 15.0
                ),
                controller: BaseTabTextEditingState().getController(),
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                      color: AppTheme.chatGrey
                  ),
                ),
//                focusNode: focusNode, // TODO:
              ),
            ),
          ),

          // Send button
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => BaseTabTextEditingState().notify(),
                color: AppTheme.chatPrimary,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
