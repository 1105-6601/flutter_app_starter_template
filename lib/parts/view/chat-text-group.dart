import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_starter_template/pages/base-tab.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'chat-text-row.dart';
import '../../app-theme.dart';

class ChatTextGroup extends StatefulWidget
{
  final String dateLabel;
  final List<ChatTextRow> rows;

  ChatTextGroup({
    this.dateLabel,
    this.rows,
  });

  @override
  _ChatTextGroupState createState() => _ChatTextGroupState();
}

class _ChatTextGroupState extends State<ChatTextGroup> with TickerProviderStateMixin
{
  AnimationController _dateLabelOpacityAnimation;

  double _dateLabelOpacity = 1.0;

  GlobalKey _dateLabelKey = GlobalKey();

  Timer timer;

  @override
  void initState()
  {
    final dateLabelOpacityTween = Tween(begin: 1.0, end: 0.0);

    _dateLabelOpacityAnimation = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )
      ..addListener(() => setState(() {
        _dateLabelOpacity = dateLabelOpacityTween.evaluate(_dateLabelOpacityAnimation);
      }));


    BaseTabScrollState().addListener(() {

      if (context == null) {
        return;
      }

      /// dateLabelUI higher position.
      /// == _BaseTabState::_buildChatView() > padding.top
      final dateLabelUIHigherPosition = MediaQuery.of(context).padding.top + 50;
      final RenderBox dateLabelBox = _dateLabelKey.currentContext.findRenderObject();
      final dateLabelOffset = dateLabelBox.localToGlobal(Offset.zero);

      if (_dateLabelOpacity != 1.0) {
        setState(() {
          _dateLabelOpacity = 1.0;
        });
      }

      if (timer != null) {
        timer.cancel();
      }

      if (_dateLabelOpacityAnimation.isAnimating) {

        _dateLabelOpacityAnimation.stop();

        if (_dateLabelOpacity != 1.0) {
          setState(() {
            _dateLabelOpacity = 1.0;
          });
        }
      }

      if (dateLabelOffset.dy > dateLabelUIHigherPosition + 10) { // 10 is tweak px
        return;
      }

      timer = Timer(Duration(milliseconds: 2000), () {
        _dateLabelOpacityAnimation.forward(from: 0.0);
      });
    });

    super.initState();
  }

  @override
  void dispose()
  {
    if (timer != null) {
      timer.cancel();
    }

    _dateLabelOpacityAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    Widget dateLabelUI = SizedBox(width: 0, height: 0);

    if (widget.dateLabel != null) {
      dateLabelUI = Opacity(
        key: _dateLabelKey,
        opacity: _dateLabelOpacity,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 6, bottom: 8),
            padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
            decoration: BoxDecoration(
                color: AppTheme.shadow9,
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: Text(
              widget.dateLabel,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.white,
              ),
            ),
          ),
        )
      );
    }

    return StickyHeader(
      header: dateLabelUI,
      content: Column(
        children: widget.rows.reversed.toList(),
      ),
    );
  }
}
