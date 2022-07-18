import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/core/router/sheet_container.dart';
import 'package:truvideo_enterprise/widget/common/gallery/screen_albums/index.dart';

enum CustomGallerySourceType {
  videos,
  pictures,
}

BuildContext? _context;

class CustomGallery {
  static set context(BuildContext? context) {
    _context = context;
  }
}

Future<File?> showCustomGallery({
  CustomGallerySourceType sourceType = CustomGallerySourceType.pictures,
}) async {
  final context = _context;
  if (context == null) return null;

  final isIOS = Platform.isIOS;

  Widget child;
  switch (sourceType) {
    case CustomGallerySourceType.videos:
      child = CustomGalleryScreenAlbums(
        params: CustomGalleryScreenAlbumsParams(
          requestType: RequestType.video,
          routeType: isIOS ? CustomRouteType.cupertinoVertical : CustomRouteType.cupertino,
        ),
      );
      break;

    case CustomGallerySourceType.pictures:
      child = CustomGalleryScreenAlbums(
        params: CustomGalleryScreenAlbumsParams(
          requestType: RequestType.image,
          routeType: isIOS ? CustomRouteType.cupertinoVertical : CustomRouteType.cupertino,
        ),
      );
      break;
  }

  Route route;
  if (isIOS) {
    route = CupertinoModalBottomSheetRoute(
      builder: (context) => child,
      containerBuilder: (context, _, child) => CupertinoBottomSheetContainer(child: child),
      expanded: true,
      elevation: 16.0,
      isDismissible: true,
      topRadius: kDefaultTopRadius,
      duration: const Duration(milliseconds: 300),
    );
  } else {
    route = customCupertinoRoute(child: child);
  }

  final file = await Navigator.of(context).push(route);
  if (file == null || file is! File) return null;
  return file;
}
