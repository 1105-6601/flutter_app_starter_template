import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card-set.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card-view-item.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card.dart';

class StackedCardView extends StatefulWidget
{
  final AnimationController animationController;
  final Animation animation;
  final StackedCardSet cardSet;

  StackedCardView({
    this.animationController,
    this.animation,
    @required this.cardSet,
  });

  @override
  _StackedCardViewState createState() => _StackedCardViewState();
}

class _StackedCardViewState extends State<StackedCardView>
{
  double _nextCardScale = 0.0;
  Key _frontItemKey;

  @override
  void initState()
  {
    super.initState();

    _setItemKey();
  }

  @override
  Widget build(BuildContext context)
  {
    return Expanded(
      child: getChild(),
    );
  }

  void _setItemKey()
  {
    _frontItemKey = Key(widget.cardSet.getKey());
  }

  void _onSlideUpdate(double distance)
  {
    setState(() {
      _nextCardScale = 0.9 + (0.1 * (distance / 100.0)).clamp(0.0, 0.1);
    });
  }

  void _onSlideComplete(SlideDirection direction)
  {
    // TODO: アクションに応じて適宜実装
    switch (direction) {
      case SlideDirection.Left:
        // nope
        break;
      case SlideDirection.Right:
        // like
        break;
      case SlideDirection.Up:
        // super like
        break;
    }

    /// スワイプした方向をフィードバック
    BotToast.showText(
      text: '$direction',
      align: Alignment(0.0, -0.91),
      duration: const Duration(seconds: 1)
    );

    /// カードインデックスを次の番号へ変更
    /// 再レンダリングさせるため Key を更新して状態変更を通知
    setState(() {
      widget.cardSet.incrementCardIndex();
      _setItemKey();
    });
  }

  Widget _buildBackItem()
  {
    return StackedCardViewItem(
      animationController: widget.animationController,
      animation: widget.animation,
      isDraggable: false,
      card: widget.cardSet.getNextCard(),
      scale: _nextCardScale
    );
  }

  Widget _buildFrontItem()
  {
    return StackedCardViewItem(
      key: _frontItemKey,
      animationController: widget.animationController,
      animation: widget.animation,
      onSlideUpdate: _onSlideUpdate,
      onSlideComplete: _onSlideComplete,
      card: widget.cardSet.getFirstCard(),
    );
  }

  Widget getChild()
  {
    return Stack(
      children: <Widget>[
        _buildBackItem(),
        _buildFrontItem(),
      ],
    );
  }

}