import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/core/video.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/controller.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/image_viewer/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/video_player/model/data.dart';
import 'package:truvideo_enterprise/widget/common/video_viewer/index.dart';

import 'file_info.dart';

class FileDialogWidget extends StatefulWidget {
  final String path;
  final CustomDialogController controller;
  final Function()? refresh;

  const FileDialogWidget({
    Key? key,
    required this.path,
    required this.controller,
    this.refresh,
  }) : super(key: key);

  @override
  State<FileDialogWidget> createState() => _FileDialogWidgetState();
}

enum _FileType {
  picture,
  video,
  other,
}

class _FileDialogWidgetState extends State<FileDialogWidget> {
  late _FileType _type;
  String _thumbnailPath = "";

  @override
  void initState() {
    final extension = widget.path.split(".").last;
    if (["png", "jpg"].contains(extension)) {
      _type = _FileType.picture;
    } else {
      if (["mp4"].contains(extension)) {
        _type = _FileType.video;
      } else {
        _type = _FileType.other;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    CustomFileUtils.delete(_thumbnailPath);
    super.dispose();
  }

  _onDeletePressed() async {
    final delete = await showCustomDialogRetry(
      title: "Delete file",
      message: "Are you sure?",
      retryButtonText: "Yes",
      cancelButtonText: "Cancel",
    );
    if (!delete) return;

    CustomFileUtils.delete(widget.path);
    widget.refresh?.call();
    widget.controller.close();
  }

  _onInfoPressed() {
    showCustomDialog(
      title: "File info",
      builder: (context, controller) => FileInfoWidget(path: widget.path),
      childPadding: EdgeInsets.zero,
      buttonsBuilder: (context, controller) => [
        CustomBorderButton.small(
          text: "Accept",
          onPressed: controller.close,
        ),
      ],
    );
  }

  _openImage() {
    showCustomImageViewer(
      [CustomImageDataSource.file(widget.path)],
      heroTagBuilder: (index) => "image",
    );
  }

  _openVideo() {
    showCustomVideoViewer(
      CustomVideoPlayerDataSource.file(widget.path),
      thumbnail: CustomImageDataSource.file(_thumbnailPath),
      thumbnailHeroTag: "video",
    );
  }

  _open() {
    switch (_type) {
      case _FileType.picture:
        _openImage();
        break;
      case _FileType.video:
        _openVideo();
        break;
      case _FileType.other:
        // TODO: Handle this case.
        break;
    }
  }

  Widget _buildTypePlaceholder() {
    switch (_type) {
      case _FileType.picture:
        return CustomImage(
          heroTag: "image",
          source: CustomImageDataSource.file(widget.path),
          width: 40,
          height: 40,
        );
      case _FileType.video:
        return HookBuilder(
          builder: (context) {
            final snapshot = useFuture(useMemoized(() => CustomVideoUtils.getThumbnail(widget.path)));
            _thumbnailPath = snapshot.data ?? "";
            return CustomImage(
              heroTag: "video",
              source: CustomImageDataSource.file(snapshot.data ?? ""),
              width: 40,
              height: 40,
            );
          },
        );
      case _FileType.other:
        break;
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_type == _FileType.picture || _type == _FileType.video)
          Column(
            children: [
              CustomListTile(
                dense: true,
                titleText: "Open",
                leading: const CustomListTileImage(
                  icon: Icons.open_in_browser,
                  color: Colors.transparent,
                ),
                trailing: _buildTypePlaceholder(),
                onPressed: _open,
              ),
              const CustomDivider(),
            ],
          ),
        CustomListTile(
          dense: true,
          titleText: "Info",
          leading: const CustomListTileImage(
            icon: Icons.info_outline,
            color: Colors.transparent,
          ),
          onPressed: _onInfoPressed,
        ),
        const CustomDivider(),
        CustomListTile(
          dense: true,
          titleText: "Delete",
          leading: const CustomListTileImage(
            icon: Icons.delete_outline,
            color: Colors.transparent,
          ),
          onPressed: _onDeletePressed,
        ),
      ],
    );
  }
}
