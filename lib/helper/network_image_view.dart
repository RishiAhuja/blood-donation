import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageView extends StatefulWidget {
  final String url;
  NetworkImageView({this.url});
  @override
  _NetworkImageViewState createState() => _NetworkImageViewState();
}

class _NetworkImageViewState extends State<NetworkImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent[200],
      ),
      body: InteractiveViewer(
        child: CachedNetworkImage(
          imageUrl: "${widget.url}",
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
