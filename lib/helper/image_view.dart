import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String path;
  ImageView({@required this.path});
   @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent[200],
      ),
      body: InteractiveViewer(
        child: Image.file(File(widget.path)),
      ),
    );
  }
}
