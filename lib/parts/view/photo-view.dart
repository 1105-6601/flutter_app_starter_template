import 'package:flutter/material.dart';

class PhotoView extends StatefulWidget
{
  final List<String> photoAssetPaths;
  final int visiblePhotoIndex;

  PhotoView({
    this.photoAssetPaths,
    this.visiblePhotoIndex
  });

  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView>
{
  int visiblePhotoIndex;

  @override
  void initState()
  {
    super.initState();

    visiblePhotoIndex = widget.visiblePhotoIndex;
  }

  void _prevImage()
  {
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex > 0
        ? visiblePhotoIndex - 1
        : widget.photoAssetPaths.length - 1;
    });
  }

  void _nextImage()
  {
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex < widget.photoAssetPaths.length - 1
        ? visiblePhotoIndex + 1
        : 0;
    });
  }

  Widget _buildBackground()
  {
    return Image.asset(
      widget.photoAssetPaths[visiblePhotoIndex],
      fit: BoxFit.cover,
    );
  }

  Widget _buildIndicator()
  {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: PhotoIndicator(
        photoCount: widget.photoAssetPaths.length,
        visiblePhotoIndex: visiblePhotoIndex,
      ),
    );
  }

  Widget _buildControls()
  {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          onTap: _prevImage,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        GestureDetector(
          onTap: _nextImage,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topRight,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context)
  {
    widget.photoAssetPaths.forEach((path) {
      precacheImage(AssetImage(path), context);
    });

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _buildBackground(),
        _buildIndicator(),
        _buildControls(),
      ],
    );
  }
}

class PhotoIndicator extends StatelessWidget
{
  final int photoCount;
  final int visiblePhotoIndex;

  PhotoIndicator({
    this.visiblePhotoIndex,
    this.photoCount
  });

  Widget _buildInactiveIndicator()
  {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Container(
          height: 3.0,
          decoration: BoxDecoration(
            color: const Color(0x33000000),
            borderRadius: BorderRadius.circular(2.5)
          ),
        ),
      ),
    );
  }

  Widget _buildActiveIndicator()
  {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Container(
          height: 3.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0x22000000),
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 1.0)
              )
            ]
          ),
        ),
      ),
    );
  }

  List<Widget> _buildIndicators()
  {
    final List<Widget> indicators = [];

    for (int i = 0; i < photoCount; i++) {
      indicators.add(i == visiblePhotoIndex ? _buildActiveIndicator() : _buildInactiveIndicator());
    }

    return indicators;
  }

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: _buildIndicators(),
      ),
    );
  }
}
