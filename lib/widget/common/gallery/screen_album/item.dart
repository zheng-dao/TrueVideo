import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';

class CustomGalleryScreenGalleryAlbumListItem extends StatelessWidget {
  final int index;
  final AssetEntity model;
  final Function(AssetEntity model, int index)? onPressed;
  final Function(AssetEntity model, int index)? onLongPressed;

  const CustomGalleryScreenGalleryAlbumListItem({
    Key? key,
    required this.model,
    this.onPressed,
    required this.index,
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateService dateService = GetIt.I.get();
    return Stack(
      children: [
        CustomImage(
          source: CustomImageDataSource.provider(
            AssetEntityImageProvider(
              model,
              isOriginal: false,
              thumbnailSize: const ThumbnailSize.square(200),
            ),
            fit: BoxFit.cover,
          ),
          heroTag: model.id,
          width: double.infinity,
          height: double.infinity,
        ),
        if (model.type == AssetType.video)
          Positioned(
            right: 4,
            bottom: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                dateService.duration(Duration(seconds: model.duration), forceHour: false),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
            ),
          ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: CustomColorsUtils.rippleColor,
              focusColor: CustomColorsUtils.rippleColor,
              hoverColor: CustomColorsUtils.rippleColor,
              splashColor: CustomColorsUtils.rippleColor,
              onTap: () => onPressed?.call(model, index),
              onLongPress: () => onLongPressed?.call(model, index),
            ),
          ),
        ),
      ],
    );
  }
}
