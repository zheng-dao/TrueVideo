import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/container/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/image_viewer/index.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/video_player/model/data.dart';
import 'package:truvideo_enterprise/widget/common/video_viewer/index.dart';

import 'item.dart';

class CustomGalleryScreenAlbumParams {
  CustomRouteType? routeType;
  final AssetPathEntity album;

  CustomGalleryScreenAlbumParams({
    this.routeType,
    required this.album,
  });
}

class CustomGalleryScreenAlbum extends StatefulHookConsumerWidget {
  final CustomGalleryScreenAlbumParams params;

  const CustomGalleryScreenAlbum({Key? key, required this.params}) : super(key: key);

  @override
  ConsumerState<CustomGalleryScreenAlbum> createState() => _CustomGalleryScreenAlbumState();
}

class _CustomGalleryScreenAlbumState extends ConsumerState<CustomGalleryScreenAlbum> {
  bool _loading = true;
  dynamic _error;
  var _data = <AssetEntity>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  _init() {
    _fetch();
  }

  _fetch() async {
    try {
      setState(() {
        _loading = true;
        _error = null;
      });

      var data = await widget.params.album.getAssetListRange(
        start: 0,
        end: widget.params.album.assetCount,
      );
      data = data.where((element) {
        if (widget.params.album.type == RequestType.video) {
          return element.type == AssetType.video;
        }

        if (widget.params.album.type == RequestType.image) {
          return element.type == AssetType.image;
        }

        return false;
      }).toList();

      if (!mounted) return;

      setState(() {
        _loading = false;
        _data = data;
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
    return widget.params.album.name;
  }

  _onItemPressed(AssetEntity model, int index) async {
    Navigator.of(context).pop(await model.file);
  }

  _onItemLongPressed(AssetEntity model, int index) async {
    if (widget.params.album.type == RequestType.video) {
      final file = await model.file;
      await showCustomVideoViewer(
        CustomVideoPlayerDataSource.file(file?.path ?? ""),
        thumbnail: CustomImageDataSource.provider(
          AssetEntityImageProvider(
            model,
            isOriginal: false,
            thumbnailSize: const ThumbnailSize.square(200),
          ),
          fit: BoxFit.contain,
        ),
        thumbnailHeroTag: model.id,
        aspectRatio: model.height.toDouble() / model.width.toDouble(),
        fromBoxFitCover: true,
      );
      CustomFileUtils.delete(file?.path ?? "");
      return;
    }

    if (widget.params.album.type == RequestType.image) {
      await showCustomImageViewer(
        _data.map((e) => CustomImageDataSource.provider(AssetEntityImageProvider(e, isOriginal: true))).toList(),
        initialIndex: index,
        heroTagBuilder: (index) => _data[index].id,
        aspectRatioBuilder: (index) => _data[index].height.toDouble() / _data[index].width.toDouble(),
        fromBoxFitCover: true,
      );

      return;
    }
  }

  _close() {
    Navigator.of(context).pop();
  }

  Widget _buildChild() {
    final sortedItems = useMemoized(
      () {
        final data = List<AssetEntity>.from(_data);
        data.sort((a, b) {
          return b.createDateTime.compareTo(a.createDateTime);
        });
        return data;
      },
      [_data],
    );

    return CustomContainer(
      mode: _loading ? CustomContainerMode.loading : (_error != null ? CustomContainerMode.error : CustomContainerMode.normal),
      errorData: _error,
      errorBuilder: (context, error) => const Center(
        key: ValueKey("error"),
        child: CustomListIndicatorError(),
      ),
      builder: (context) => CustomFadingEdgeList(
        key: const ValueKey("content"),
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16.0).copyWith(bottom: 16.0 + MediaQuery.of(context).padding.bottom),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: sortedItems.length,
          itemBuilder: (BuildContext context, int index) => CustomGalleryScreenGalleryAlbumListItem(
            model: sortedItems[index],
            onPressed: _onItemPressed,
            onLongPressed: _onItemLongPressed,
            index: index,
          ),
        ),
      ),
    );
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
        backgroundColor: appBarFillColor,
        titleColor: appBarIconColor,
        leading: isRouteTypeCupertinoVertical ? null : buttonClose,
        actionButtons: [
          CustomButtonIcon(
            icon: Icons.refresh,
            iconColor: appBarIconColor,
            backgroundColor: Colors.transparent,
            onPressed: _fetch,
          ),
          if (isRouteTypeCupertinoVertical) buttonClose,
        ],
      ),
      body: _buildChild(),
    );
  }
}
