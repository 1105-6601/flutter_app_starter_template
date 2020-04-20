import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_starter_template/entity/message.dart';
import 'package:flutter_app_starter_template/parts/view/animated-view.dart';
import 'package:flutter_app_starter_template/parts/view/chat-text-group.dart';
import 'package:flutter_app_starter_template/parts/view/chat-user.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../app-theme.dart';

enum BaseTabType
{
  List,
  Column,
  Chat,
}

abstract class BaseTab extends StatefulWidget
{
  const BaseTab({
    Key key,
    this.animationController,
    this.changeTabBody,
    this.showBackLink: false,
    this.backIcon: Icons.arrow_back_ios,
    this.type,
  }) : super(key: key);

  const BaseTab.list({
    Key key,
    this.animationController,
    this.changeTabBody,
    this.showBackLink: false,
    this.backIcon: Icons.arrow_back_ios,
  }) : type = BaseTabType.List,
       super(key: key);

  const BaseTab.column({
    Key key,
    this.animationController,
    this.changeTabBody,
    this.showBackLink: false,
    this.backIcon: Icons.arrow_back_ios,
  }) : type = BaseTabType.Column,
       super(key: key);

  const BaseTab.chat({
    Key key,
    this.animationController,
    this.changeTabBody,
    this.showBackLink: false,
    this.backIcon: Icons.arrow_back_ios,
  }) : type = BaseTabType.Chat,
       super(key: key);

  final AnimationController animationController;
  final Function(Widget widget) changeTabBody;
  final bool showBackLink;
  final IconData backIcon;
  final BaseTabType type;

  @override
  BaseTabState createState() => BaseTabState();

  @protected
  String getTitle();

  @protected
  Image resolveIconImage()
  {
    return null;
  }

  @protected
  String resolveIconImageAsUrl()
  {
    return null;
  }

  @protected
  Future<List<Widget>> initWidgets(BuildContext context) async
  {
    return [];
  }

  @protected
  Future<List<Message>> initMessages(BuildContext context) async
  {
    return [];
  }

  @protected
  Future<void> loadPastMessages(DateTime before, BaseTabState state) async
  {
  }

  @protected
  List<ChatTextGroup> buildMessageGroups(List<Message> messages)
  {
    return [];
  }

  @protected
  Widget buildChatInputControlBar()
  {
    return const SizedBox(width: 0, height: 0);
  }

  @protected
  void onBackLinkTap()
  {
  }

  @protected
  void onSwipeRight()
  {
  }
}

class BaseTabScrollState extends ChangeNotifier
{
  static BaseTabScrollState _instance;

  factory BaseTabScrollState() {
    if (_instance == null) {
      _instance = BaseTabScrollState._internal();
    }

    return _instance;
  }

  BaseTabScrollState._internal();

  ScrollController _controller;

  void setController(ScrollController controller)
  {
    _controller = controller;
  }

  ScrollController getController()
  {
    return _controller;
  }

  void onScroll()
  {
    notifyListeners();
  }
}

class BaseTabTextEditingState extends ChangeNotifier
{
  static BaseTabTextEditingState _instance;

  factory BaseTabTextEditingState() {
    if (_instance == null) {
      _instance = BaseTabTextEditingState._internal();
    }

    return _instance;
  }

  BaseTabTextEditingState._internal();

  TextEditingController _controller;

  void setController(TextEditingController controller)
  {
    _controller = controller;
  }

  TextEditingController getController()
  {
    return _controller;
  }

  void notify()
  {
    notifyListeners();
  }
}

class BaseTabState extends State<BaseTab> with TickerProviderStateMixin
{
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  Animation<double> _topBarAnimation;
  double _topBarOpacity = 0.0;
  List<Widget> _widgets = [];
  List<Message> _messages = [];
  bool _widgetsInitialized = false;
  bool _messagesInitialized = false;

  @override
  void initState()
  {
    if (widget.type == BaseTabType.Chat) {
      _topBarOpacity = 1.0;
    }

    _topBarAnimation = UiUtil.createAnimation(widget.animationController, 0);

    final minAnimateHeight = 0;
    final maxAnimateHeight = 24;

    _scrollController.addListener(() {

      if (widget.type == BaseTabType.Chat) {
        if (_topBarOpacity != 1.0) {
          setState(() {
            _topBarOpacity = 1.0;
          });
        }
      } else {
        if (_scrollController.offset > maxAnimateHeight) {
          if (_topBarOpacity != 1.0) {
            setState(() {
              _topBarOpacity = 1.0;
            });
          }
        } else if (minAnimateHeight < _scrollController.offset && _scrollController.offset <= maxAnimateHeight) {
          if (_topBarOpacity != _scrollController.offset / maxAnimateHeight) {
            setState(() {
              _topBarOpacity = _scrollController.offset / maxAnimateHeight;
            });
          }
        } else if (_scrollController.offset <= minAnimateHeight) {
          if (_topBarOpacity != 0.0) {
            setState(() {
              _topBarOpacity = 0.0;
            });
          }
        }
      }

      BaseTabScrollState().onScroll();
    });

    BaseTabScrollState().setController(_scrollController);
    BaseTabTextEditingState()
      ..setController(_textEditingController)
      ..addListener(_onMessageReceived);

    super.initState();
  }

  void addMessages(List<Message> messages)
  {
    setState(() {
      _messages.addAll(messages);
    });
  }

  void _onMessageReceived()
  {
    final value = _textEditingController.text.trim();
    if (value == '') {
      return;
    }

    final newMessage = Message(
      isImage: false,
      text:    value,
      date:    DateTime.now(),
      user:    ChatUser.generateMockSelf(), // FIXME: Replace to valid logged in user.
    );

    setState(() {
      final newMessages = <Message>[newMessage];
      newMessages.addAll(_messages);
      _messages = newMessages;
    });

    _textEditingController.clear();
    _scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context)
  {
    widget.animationController.forward();

    Widget content;

    switch (widget.type) {
      case BaseTabType.List:
        content = _createListView();
        break;
      case BaseTabType.Column:
        content = _createColumnView();
        break;
      case BaseTabType.Chat:
        content = _createChatView();
        break;
      default:
        content = Container();
        break;
    }

    return GestureDetector(
      onPanUpdate: (details) {
        /// Swiping in right direction
        if (details.delta.dx > 25) {
          widget.onSwipeRight();
        }
      },
      child: content,
    );
  }

  double _getMediaSize({String type})
  {
    final size = MediaQuery.of(context);

    switch (type) {
      case 'padding-top':
        return size.padding.top; /// e.g.) iPhone Xs max => 44, Android(Nexus_6) => 24
        break;
      case 'padding-bottom':
        return size.padding.bottom; /// e.g.) iPhone Xs max => 34, Android(Nexus_6) => 0
        break;
      default:
        return 0.0;
    }
  }

  Widget _createListView()
  {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[

            _initializer<bool>(_initWidgets, () {
              return  ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height + _getMediaSize(type: 'padding-top') + 24,
                  bottom: UiUtil.displayBottomMargin(context) + 62,
                ),
                itemCount: _widgets.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return _widgets[index];
                },
              );
            }),

            _buildAppBar(),
          ],
        ),
      ),
    );
  }

  Widget _createColumnView()
  {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[

            _initializer<bool>(_initWidgets, () {
              return Padding(
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height + _getMediaSize(type: 'padding-top') + 24,
                  bottom: UiUtil.displayBottomMargin(context) + 62,
                ),
                child: Column(
                  children: _widgets,
                ),
              );
            }),

            _buildAppBar(),
          ],
        ),
      ),
    );
  }

  Widget _createChatView()
  {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            _initializer<bool>(_initMessages, _buildChatListView),
            _buildChatInputUI(),
            _buildAppBar(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<T> _initializer<T>(Function future, Function builder)
  {
    return FutureBuilder(
      future: future(),
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(width: 0, height: 0);
        }

        return builder();
      },
    );
  }

  Future<bool> _initWidgets() async
  {
    if (_widgetsInitialized) {
      return true;
    }

    _widgetsInitialized = true;

    _widgets = await widget.initWidgets(context);

    return true;
  }

  Future<bool> _initMessages() async
  {
    if (_messagesInitialized) {
      return true;
    }

    _messagesInitialized = true;

    _messages = await widget.initMessages(context);

    return true;
  }

  Widget _buildChatListView()
  {
    final messageGroups = widget.buildMessageGroups(_messages);

    return Padding(
      padding: EdgeInsets.only(
        top: _getMediaSize(type: 'padding-top') + 50,
      ),
      child: ListView.builder(
        reverse: true,
        controller: _scrollController,
        padding: EdgeInsets.only(
          bottom: UiUtil.displayBottomMargin(context) + 104,
        ),
        itemCount: messageGroups.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {

          if (index >= messageGroups.length - 1) {
            // Loading next items
            Future.delayed(Duration.zero, () {
              final oldestMessageGroup = messageGroups[messageGroups.length - 1];
              final rowsLength = oldestMessageGroup.rows.length;
              final oldestMessage = oldestMessageGroup.rows[rowsLength - 1];

              widget.loadPastMessages(oldestMessage.date, this);
            });
          }

          return messageGroups[index];
        },
      ),
    );
  }

  Widget _buildChatInputUI()
  {
    return Positioned(
      bottom: UiUtil.displayBottomMargin(context) + 50,
      left:  0,
      right: 0,
      child: Container(
        color: AppTheme.white,
        width: double.infinity,
        height: 50,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[

            // Overflow white mask
            Positioned(
              left: 0,
              right: 0,
              top: 50,
              child: Container(
                color: AppTheme.white,
                height: UiUtil.displayBottomMargin(context) + 50,
              ),
            ),

            // Main input UI
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                color: AppTheme.white,
                child: widget.buildChatInputControlBar(),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildAppBar()
  {
    return Column(
      children: <Widget>[
        AnimatedView(
          animationController: widget.animationController,
          animation: _topBarAnimation,
          child: _getAppBarChild(),
          movingDistance: 0,
        ),
      ]
    );
  }

  Widget _getAppBarChild()
  {
    Radius radius = const Radius.circular(32.0);
    if (widget.type == BaseTabType.Chat) {
      radius = const Radius.circular(0.0);
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(_topBarOpacity),
        borderRadius: BorderRadius.only(
          bottomLeft: radius,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.grey.withOpacity(0.4 * _topBarOpacity),
            offset: const Offset(1.1, 1.1),
            blurRadius: 10.0
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _getMediaSize(type: 'padding-top'),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16 - 8.0 * _topBarOpacity,
              bottom: 12 - 8.0 * _topBarOpacity
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildBackWidget(),
                _buildIconImage(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 4, top: 8, bottom: 8),
                    child: Text(
                      widget.getTitle(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 18 + 6 - 6 * _topBarOpacity,
                        letterSpacing: 1.2,
                        color: AppTheme.darkerText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBackWidget()
  {
    if (!widget.showBackLink) {
      return const SizedBox(width: 0, height: 0);
    }

    return GestureDetector(
      onTap: widget.onBackLinkTap,
      child: SizedBox(
        height: 40 - (10 * _topBarOpacity),
        width: 40 - (10 * _topBarOpacity),
        child: Icon(
          widget.backIcon,
          color: AppTheme.darkText,
          size: 20 - (5 * _topBarOpacity),
        ),
      ),
    );
  }

  Widget _buildIconImage()
  {
    Widget iconImage = const SizedBox(width: 0, height: 0);

    final hasIconImage    = widget.resolveIconImage() != null;
    final hasIconImageUrl = widget.resolveIconImageAsUrl() != null;
    final iconSize = 40 - (10 * _topBarOpacity);

    if (hasIconImage) {
      iconImage = Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
        child: new Container(
            height: iconSize,
            width: iconSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: widget.resolveIconImage().image,
              ),
            )
        ),
      );
    } else if (hasIconImageUrl) {
      iconImage = Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        child: CachedNetworkImage(
          imageUrl: widget.resolveIconImageAsUrl(),
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
      );
    }

    return iconImage;
  }
}