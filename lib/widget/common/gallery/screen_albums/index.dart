import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
 import 'package:photo_manager/photo_manager.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/permission.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/core/router/sheet_container.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/gallery/screen_album/index.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/dialog/permission/index.dart';

class CustomGalleryScreenAlbumsParams {
  CustomRouteType? routeType;
  final RequestType requestType;

  CustomGalleryScreenAlbumsParams({
    this.routeType,
    required this.requestType,
  });
}

class CustomGalleryScreenAlbums extends StatefulWidget {
  final CustomGalleryScreenAlbumsParams params;

  const CustomGalleryScreenAlbums({Key? key, required this.params}) : super(key: key);

  @override
  State<CustomGalleryScreenAlbums> createState() => _CustomGalleryScreenAlbumsState();
}

class _CustomGalleryScreenAlbumsState extends State<CustomGalleryScreenAlbums> {
  bool _loading = true;
  dynamic _error;
  var _paths = <AssetPathEntity>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  _init() async {
    final withPermission = await showCustomPermissionDialog(CustomPermissionUtils.galleryPermissions);
    if (!withPermission) {
      _close();
      return;
    }

    _fetch();
  }

  _fetch() async {
    try {
      setState(() {
        _loading = true;
        _error = null;
      });

      final paths = await PhotoManager.getAssetPathList(type: widget.params.requestType);
      if (!mounted) return;

      setState(() {
        _loading = false;
        _paths = paths;
      });
    } catch (error, stack) {
      log("Error fetching", error: error, stackTrace: stack);
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = error;
      });
    }
  }

  String get _title {
    if (widget.params.requestType == RequestType.video) return "Videos";
    if (widget.params.requestType == RequestType.image) return "Pictures";
    return "";
  }

  _close() {
    Navigator.of(context).pop();
  }

  _onItemPressed(AssetPathEntity model) async {
    final isIOS = Platform.isIOS;

    final child = CustomGalleryScreenAlbum(
      params: CustomGalleryScreenAlbumParams(
        album: model,
        routeType: isIOS ? CustomRouteType.cupertinoVertical : CustomRouteType.cupertino,
      ),
    );
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
    if (file == null || file is! File) return;
    if (!mounted) return;
    Navigator.of(context).pop(file);
  }

  @override
  Widget build(BuildContext context) {
    final isRouteTypeCupertinoVertical = widget.params.routeType == CustomRouteType.cupertinoVertical;
    Color appBarFillColor;
    Color appBarIconColor;
    if (isRouteTypeCupertinoVertical) {
      appBarFillColor = Theme.of(context).scaffoldBackgroundColor;
    } else {
      appBarFillColor = Theme.of(context).colorScheme.secondary;
    }
    appBarIconColor = appBarFillColor.contrast(context);

    final buttonClose = CustomButtonIcon(
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      iconColor: appBarIconColor,
      backgroundColor: Colors.transparent,
      onPressed: _close,
    );

    return CustomScaffold(
      appbar: CustomAppBar(
        title: _title,
        titleColor: appBarIconColor,
        backgroundColor: appBarFillColor,
        leading: isRouteTypeCupertinoVertical ? null : buttonClose,
        actionButtons: [
          CustomButtonIcon(
            icon: Icons.refresh,
            backgroundColor: Colors.transparent,
            iconColor: appBarIconColor,
            onPressed: _fetch,
          ),
          if (isRouteTypeCupertinoVertical) buttonClose,
        ],
      ),
      body: CustomFadingEdgeList(
        child: CustomList<AssetPathEntity>.separated(
          padding: const EdgeInsets.symmetric(vertical: 16.0).copyWith(bottom: 100.0 + MediaQuery.of(context).viewPadding.bottom),
          loading: _loading,
          data: _paths,
          error: _error,
          itemBuilder: (context, item) => CustomListTile(
            titleText: item.name,
            onPressed: () => _onItemPressed(item),
          ),
          areItemsTheSame: (a, b) => a.id == b.id,
        ),
      ),
    );
  }
}
