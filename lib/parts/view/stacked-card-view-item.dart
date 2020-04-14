import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card-view-item-content.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card.dart';
import 'package:fluttery_dart2/layout.dart';

enum SlideDirection {
  Left,
  Right,
  Up,
}

class StackedCardViewItem extends StatefulWidget
{
  final AnimationController animationController;
  final Animation animation;
  final bool isDraggable;
  final StackedCard card;
  final Function(double) onSlideUpdate;
  final Function(SlideDirection) onSlideComplete;
  final double scale;

  StackedCardViewItem({
    Key key,
    this.animationController,
    this.animation,
    this.isDraggable: true,
    @required this.card,
    this.onSlideUpdate,
    this.onSlideComplete,
    this.scale: 1.0,
  }) : super(key: key);

  @override
  _StackedCardViewItemState createState() => _StackedCardViewItemState();
}

class _StackedCardViewItemState extends State<StackedCardViewItem> with TickerProviderStateMixin
{
  GlobalKey itemKey = GlobalKey(debugLabel: 'item_key');

  Offset containerOffset = const Offset(0.0, 0.0);
  Offset dragStartPosition;
  Offset dragCurrentPosition;
  Offset slideBackStartPosition;

  AnimationController slideBackAnimation;
  AnimationController slideOutAnimation;
  Tween<Offset> slideOutTween;
  SlideDirection slideOutDirection;

  @override
  void initState()
  {
    super.initState();

    /// スライドバック用（ドラッグを解除した場合）のアニメーション処理
    slideBackAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      /// `slideBackAnimation.forward()`がコールされた際に実行されるリスナー
      ..addListener(() => setState(() {

        /// slideBackAnimation.value: アニメーションの時間経過に伴って 0.0 => 1.0 まで線形に増加する
//        print('slideBackAnimation.value: ${slideBackAnimation.value}');

        /// Curves.elasticOut.transform(): 指定された時刻 t（0.0 <= t <= 1.0）における振動曲線上の位置 y を計算する
        /// @see https://api.flutter.dev/flutter/animation/Curves/elasticOut-constant.html
//        print('Curves.elasticOut.transform(slideBackAnimation.value): ${Curves.elasticOut.transform(slideBackAnimation.value)}');

        /// Translate from document:
        /// `Offset.lerp(Offset a, Offset b, double t)`
        /// 2つのオフセット間を直線的に補間します。
        /// どちらかのオフセットが null の場合、この関数は Offset.zero から補間します。
        /// t 引数はタイムライン上の位置を表し、
        /// 0.0は補間が開始されていないことを意味し、a（または a と同等のもの）を返し、
        /// 1.0は補間が終了したことを意味し、b（または b と同等のもの）を返し、
        /// その間の値は補間がタイムライン上の a と b の間の関連するポイントにあることを意味します。
        /// t の値は通常 AnimationController のような Animation<double> から取得します。
        ///
        /// コンテナのドラッグが解除された座標(slideBackStart)から 初期位置(Offset(0, 0))までの座標を Curves.elasticOut（振動曲線） にて補完
        containerOffset = Offset.lerp(
            slideBackStartPosition,
            const Offset(0.0, 0.0),
            Curves.elasticOut.transform(slideBackAnimation.value)
        );

        /// リスナーが設定されている場合、移動した距離（対角距離）を渡して実行
        if (widget.onSlideUpdate != null) {
          widget.onSlideUpdate(containerOffset.distance);
        }
      }))
      /// アニメーションの実行状態を受信するリスナー
      ..addStatusListener((AnimationStatus status) {
        /// アニメーションが完了通知を受信した際に実行
        if (status == AnimationStatus.completed) {
          setState(() {
            /// 各種ポジション情報をクリア
            /// ドラッグ開始位置
            dragStartPosition = null;
            /// ドラッグ中の位置
            dragCurrentPosition = null;
            /// ドラッグが解除された座標
            slideBackStartPosition = null;
          });
        }
      });

    /// スライドアウト用のアニメーション処理
    slideOutAnimation = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      /// `slideOutAnimation.forward()`がコールされた際に実行されるリスナー
      ..addListener(() => setState(() {
        /// 時間経過とともに変化するコンテナのポジション(Offset)をslideOutTweenを用いて計算し更新
        containerOffset = slideOutTween.evaluate(slideOutAnimation);

        /// リスナーが設定されている場合、移動した距離（対角距離）を渡して実行
        if (widget.onSlideUpdate != null) {
          widget.onSlideUpdate(containerOffset.distance);
        }
      }))
      /// アニメーションの実行状態を受信するリスナー
      ..addStatusListener((AnimationStatus status) {
        /// アニメーションが完了通知を受信した際に実行
        if (status == AnimationStatus.completed) {
          setState(() {
            /// 各種ポジション情報をクリア
            /// ドラッグ開始位置
            dragStartPosition = null;
            /// ドラッグ中の位置
            dragCurrentPosition = null;
            /// スライドアウトアニメーションの設定情報（軌道、距離等）をクリア
            slideOutTween = null;

            /// リスナーが設定されている場合、スライドされた方向を渡して実行
            if (widget.onSlideComplete != null) {
              widget.onSlideComplete(slideOutDirection);
            }
          });
        }
      });
  }

  @override
  void dispose()
  {
    slideBackAnimation.dispose();
    slideOutAnimation.dispose();
    super.dispose();
  }

  /// ドラッグ開始処理
  /// ドラッグが開始された画面上の絶対位置(x, y)を保持する
  void _onPanStart(DragStartDetails details)
  {
    if (!widget.isDraggable) {
      return;
    }

    /// details.globalPosition はデバイス上の絶対位置
    dragStartPosition = details.globalPosition;

    if (slideBackAnimation.isAnimating) {
      slideBackAnimation.stop();
    }
  }

  /// ドラッグ中の処理
  /// ドラッグ開始位置から現在のドラッグ位置を減算し、ドラッグ開始位置からの移動量を計算
  /// setState にて常に値を更新
  void _onPanUpdate(DragUpdateDetails details)
  {
    if (!widget.isDraggable) {
      return;
    }

    setState(() {
      /// details.globalPosition はデバイス上の絶対位置
      dragCurrentPosition = details.globalPosition;
      /// 現在のドラッグ位置からドラッグ開始位置を減算して、コンテナの移動量を計算
      containerOffset = dragCurrentPosition - dragStartPosition;

      /// リスナーが設定されている場合、移動した距離（対角距離）を渡して実行
      if (widget.onSlideUpdate != null) {
        widget.onSlideUpdate(containerOffset.distance);
      }
    });
  }

  /// ドラッグ終了処理
  /// コンテナのドラッグが解除された際に実行
  void _onPanEnd(DragEndDetails details)
  {
    /// ドラッグされた方向をベクトル成分(x, y)として計算
    /// Offset.distance は(0, 0)から現在位置の対角距離
    /// Offset(xの移動量, yの移動量) / 移動した距離（対角距離）、なので
    /// 右下ベクトルの場合、xy共に正    (e.g. (0.5, 0.5)
    /// 右上ベクトルの場合、xが正、yが負 (e.g. (0.5, -0.5)
    /// 左下ベクトルの場合、xが負、yが正 (e.g. (-0.5, 0.5)
    /// 左上ベクトルの場合、xy共に負    (e.g. (-0.5, -0.5)
    final dragVector = containerOffset / containerOffset.distance;

    /// コンテナサイズと移動量を用いてどのエリアにドラッグされたかを判定
    /// xの移動量(cardOffset.dx)がコンテナサイズの45%を超えたら右、-45%を下回ったら左
    /// yの移動量(cardOffset.dy)がコンテナサイズの-40%を下回ったら上
    final isInLeftRegion = (containerOffset.dx / context.size.width) < -0.45;
    final isInRightRegion = (containerOffset.dx / context.size.width) > 0.45;
    final isInTopRegion = (containerOffset.dy / context.size.height) < -0.40;

    setState(() {
      /// 左か右エリアの場合
      if (isInLeftRegion || isInRightRegion) {
        /// Tweenの開始位置は現在のコンテナのドラッグ位置
        /// 終了位置は、コンテナ幅 x 2 * ドラッグされたベクトル成分で算出（方向ベクトルを増幅させる形）
        /// ドラッグした方向（軌道）を維持し、その移動量を加味した点を終点に置くことで、
        /// コンテナを投げ飛ばす感覚を表現
        slideOutTween = Tween(begin: containerOffset, end: dragVector * (2 * context.size.width));

        /// スライドアウトアニメーションを先頭フレームから実行
        slideOutAnimation.forward(from: 0.0);

        /// 最終的にスライドされた方向を通知用にセット
        slideOutDirection = isInLeftRegion ? SlideDirection.Left : SlideDirection.Right;

      } else if (isInTopRegion) {
        /// 上エリアの場合
        /// 終了位置は、コンテナの高さ x 2 * ドラッグされたベクトル成分で算出
        slideOutTween = Tween(begin: containerOffset, end: dragVector * (2 * context.size.height));

        /// スライドアウトアニメーションを先頭フレームから実行
        slideOutAnimation.forward(from: 0.0);

        /// 最終的にスライドされた方向を通知用にセット
        slideOutDirection = SlideDirection.Up;

      } else {
        /// どのエリアにも該当しない場合
        /// スライドバックアニメーションの開始点を現在のドラッグ位置に設定
        slideBackStartPosition = containerOffset;

        /// スライドバックアニメーションを先頭フレームから実行
        slideBackAnimation.forward(from: 0.0);
      }
    });
  }

  /// ドラッグした際の回転角を計算する
  double _rotation(Rect dragBounds)
  {
    if (dragStartPosition != null) {
      /// コンテナの中央より上の場合は時計回り(1)、下の場合は半時計回り(-1)に設定
      final rotationCornerMultiplier = dragStartPosition.dy >= dragBounds.top + (dragBounds.height / 2) ? -1 : 1;

      /// ドラッグされた移動量に応じて回転角を増減させる
      /// 最大で pi / 8 = 22.5 radian の傾きを返却する
      final angle = (pi / 8) * (containerOffset.dx / dragBounds.width);

      /// 回転角を返却
      return angle * rotationCornerMultiplier;
    } else {
      /// ドラッグが開始されていない場合は 0 radian を返却
      return 0.0;
    }
  }

  /// ドラッグした際の回転角の起点となるポジションを計算する
  /// ドラッグが開始されていない場合は x, y 共に0を返却
  /// ドラッグ開始位置からドラッグ可能エリア左上の位置を減算し、ドラッグ可能エリア内におけるオフセットを計算する
  Offset _rotationOrigin(Rect dragBounds)
  {
    if (dragStartPosition != null) {
      return dragStartPosition - dragBounds.topLeft;
    } else {
      return const Offset(0.0, 0.0);
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return getChild();
  }

  Widget getChild()
  {
    /// Translate from document:
    /// AnchoredOverlay は OverlayBuilder と似ていますが、 AnchoredOverlay の中心になるように計算されたアンカー Offset も提供します。
    /// これにより、他の Widgets の上に Widgets を簡単に貼り付けることができます。例えば、ポップオーバーなどです。
    return AnchoredOverlay(
      showOverlay: true,
      child: Center(),
      overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor) {
        /// Translate from document:
        /// CenterAbout は、子ウィジェットを指定された Offset で中央に配置します。スタックで使用する必要があります。
        return CenterAbout(
          position: anchor,
          child: Transform(
            transform:
            /// xy 軸の移動
            Matrix4.translationValues(containerOffset.dx, containerOffset.dy, 0.0)
              /// z 軸方向の回転を制御
              ..rotateZ(_rotation(anchorBounds))
              /// コンテナのスケールを設定
              ..scale(widget.scale, widget.scale),
            /// Transform 処理の原点となる座標を設定
            origin: _rotationOrigin(anchorBounds),
            /// scale が 1.0 でない場合のみ（バックカードのみ）、 alignment を center に設定する
            alignment: widget.scale != 1.0 ? Alignment.center : null,
            child: Container(
              key: itemKey,
              width: anchorBounds.width,
              height: anchorBounds.height,
              padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 8),
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: StackedCardViewItemContent(
                  animationController: widget.animationController,
                  animation: widget.animation,
                  card: widget.card,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}