import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card-view-item.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card.dart';

class StackedCardView extends StatefulWidget
{
  final AnimationController animationController;
  final Animation animation;
  final List<StackedCard> cards;

  StackedCardView({
    this.animationController,
    this.animation,
    @required this.cards,
  });

  @override
  _StackedCardViewState createState() => _StackedCardViewState();
}

class _StackedCardViewState extends State<StackedCardView>
{
  int _currentCardIndex = 0;
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
    _frontItemKey = Key(_getFirstCard().title);
  }

  void _incrementCardIndex()
  {
    _currentCardIndex = _currentCardIndex < widget.cards.length - 1 ? _currentCardIndex + 1 : 0;
  }

  StackedCard _getFirstCard()
  {
    return widget.cards[_currentCardIndex];
  }

  StackedCard _getNextCard()
  {
    return _currentCardIndex < widget.cards.length - 1 ? widget.cards[_currentCardIndex + 1] : widget.cards[0];
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

    setState(() {
      _incrementCardIndex();
      _setItemKey();
    });
  }

  Widget _buildBackItem()
  {
    return StackedCardViewItem(
      animationController: widget.animationController,
      animation: widget.animation,
      isDraggable: false,
      card: _getNextCard(),
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
      card: _getFirstCard(),
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