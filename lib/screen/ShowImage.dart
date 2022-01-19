import 'package:flutter/material.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:photo_view/photo_view.dart';

class ShowImage extends StatefulWidget {
  String image;
  ShowImage(this.image);

  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child:  PhotoView(
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: 10
                      ,
                ),
              ),
            ),
            minScale: .1,
            initialScale: PhotoViewComputedScale.contained * 0.8,
              imageProvider: NetworkImage(widget.image),
          ),

        ),
      ),
    );
  }
}
