import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class CustomGalleryPanelAlbum extends StatelessWidget {
  final RequestType requestType;
  final AssetPathEntity album;

  const CustomGalleryPanelAlbum({
    Key? key,
    required this.requestType,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
