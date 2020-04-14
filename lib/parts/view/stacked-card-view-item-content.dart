import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/photo-view.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card.dart';
import '../../app-theme.dart';
import 'animated-view.dart';

class StackedCardViewItemContent extends StatefulWidget
{
  final AnimationController animationController;
  final Animation animation;
  final StackedCard card;

  StackedCardViewItemContent({
    Key key,
    this.animationController,
    this.animation,
    this.card,
  }): super(key: key);

  @override
  _StackedCardViewItemContentState createState() => _StackedCardViewItemContentState();
}

class _StackedCardViewItemContentState extends State<StackedCardViewItemContent> with TickerProviderStateMixin
{
  Widget _buildBackground()
  {
    return PhotoView(
      photoAssetPaths: widget.card.photos,
      visiblePhotoIndex: 0,
    );
  }

  Widget _buildProfile()
  {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ]
          )
        ),
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.card.title,
                    style: TextStyle(color: Colors.white, fontSize: 24.0)
                  ),
                  Text(
                    widget.card.subTitle,
                    style: TextStyle(color: Colors.white, fontSize: 18.0)
                  )
                ],
              ),
            ),
            Icon(
              Icons.info,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return AnimatedView(
      animationController: widget.animationController,
      animation: widget.animation,
      child: getChild(),
    );
  }

  Widget getChild()
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadow1,
            blurRadius: 5.0,
            spreadRadius: 2.0,
          )
        ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildBackground(),
              _buildProfile(),
            ],
          ),
        ),
      ),
    );
  }
}