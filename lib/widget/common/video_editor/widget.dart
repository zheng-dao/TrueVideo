import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/model/camera/camera_picture_file.dart';
import 'package:truvideo_enterprise/model/camera/camera_result.dart';
import 'package:truvideo_enterprise/model/camera/camera_video_file.dart';
import 'package:truvideo_enterprise/model/camera/video_info.dart';
import 'package:truvideo_enterprise/model/video_editor/processing_picture.dart';
import 'package:truvideo_enterprise/model/video_editor/processing_video.dart';
import 'package:truvideo_enterprise/model/video_editor/request_picture.dart';
import 'package:truvideo_enterprise/model/video_editor/request_video.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/core/colors.dart';

import 'pager_content.dart';
import 'pager_preview.dart';
import 'utils.dart';

class CustomVideoEditorScreen extends StatefulHookConsumerWidget {
  final List<VideoEditorRequestVideoModel> videos;
  final List<VideoEditorRequestPictureModel> pictures;
  final int? orderID;

  const CustomVideoEditorScreen({
    Key? key,
    required this.videos,
    required this.pictures,
    this.orderID,
  }) : super(key: key);

  @override
  ConsumerState<CustomVideoEditorScreen> createState() => _CustomVideoEditorScreenState();
}

class _CustomVideoEditorScreenState extends ConsumerState<CustomVideoEditorScreen> {
  bool _processing = false;

  Duration? _startDuration;
  Duration? _endDuration;

  VideoEditorProcessingVideoModel? _video;
  var _pictures = <VideoEditorProcessingPictureModel>[];

  final _pageController = PageController(initialPage: 0, keepPage: true);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    super.dispose();
    _deleteAll();
  }

  _init() async {
    if (widget.videos.isEmpty) {
      await showCustomDialogRetry(
        title: "Error",
        message: "No videos found",
      );
      _close();
      return;
    }

    _deleteAll();

    var pictures = <VideoEditorProcessingPictureModel>[];
    for (var element in widget.pictures) {
      pictures.add(
        VideoEditorProcessingPictureModel(
          picture: const CameraPictureFileModel(),
          error: null,
          loading: true,
          originalPath: element.path,
        ),
      );
    }

    setState(() {
      _video = null;
      _pictures = pictures;
    });

    await _initVideo();
    if (!mounted) {
      _deleteAll();
      return;
    }

    for (var picture in widget.pictures) {
      if (!mounted) {
        _deleteAll();
        break;
      }

      await _initPicture(picture.path);
    }
  }

  _deleteAll() {
    if (_video != null) {
      CustomFileUtils.delete(_video!.video.info.path);
      CustomFileUtils.delete(_video!.video.thumbnailPath);
    }

    for (var element in _pictures) {
      CustomFileUtils.delete(element.picture.path);
    }
  }

  _initVideo() async {
    if (_video != null) {
      CustomFileUtils.delete(_video?.video.info.path ?? "");
      CustomFileUtils.delete(_video?.video.thumbnailPath ?? "");
    }

    final createdFiles = <String>[];

    _deleteCreatedFiles() {
      for (var element in createdFiles) {
        CustomFileUtils.delete(element);
      }
      createdFiles.clear();
    }

    try {
      final data = [];
      for (var element in widget.videos) {
        data.add({"path": element.path, "rotation": element.rotation});
      }

      setState(() {
        _video = const VideoEditorProcessingVideoModel(
          video: CameraVideoFileModel(info: VideoInfoModel()),
          loading: true,
          error: null,
        );
      });

      // Process videos
      final videosForConcatenate = <String>[];
      for (var video in widget.videos) {
        final rotated = await VideoEditorUtils.rotateVideo(
          video.path,
          video.rotation,
          orderID: widget.orderID,
        );
        createdFiles.add(rotated);
        await Future.delayed(const Duration(milliseconds: 100));
        videosForConcatenate.add(rotated);
        if (!mounted) {
          _deleteCreatedFiles();
          return;
        }
      }

      if (!mounted) {
        _deleteCreatedFiles();
        return;
      }

      // Concat the videos
      final concatenatedVideo = await VideoEditorUtils.concatVideos(videosForConcatenate, orderID: widget.orderID);
      createdFiles.add(concatenatedVideo);
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) {
        _deleteCreatedFiles();
        return;
      }

      // Get video info
      final resultVideoInfo = await VideoEditorUtils.getVideoInfo(concatenatedVideo, orderID: widget.orderID);
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) {
        _deleteCreatedFiles();
        return;
      }

      // Get video thumbnail
      final resultThumbnail = await VideoEditorUtils.getVideoThumbnail(concatenatedVideo, orderID: widget.orderID);
      createdFiles.add(resultThumbnail);
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) {
        _deleteCreatedFiles();
        return;
      }

      final resultVideo = CameraVideoFileModel(
        thumbnailPath: resultThumbnail,
        info: resultVideoInfo,
      );

      // Delete rotated videos
      for (var element in videosForConcatenate) {
        CustomFileUtils.delete(element);
      }

      setState(() {
        _video = VideoEditorProcessingVideoModel(
          video: resultVideo,
          loading: false,
          error: null,
        );
      });
    } catch (error, stack) {
      log("Error init video", error: error, stackTrace: stack);
      if (!mounted) return;

      _deleteCreatedFiles();

      _video = VideoEditorProcessingVideoModel(
        video: const CameraVideoFileModel(info: VideoInfoModel()),
        loading: false,
        error: error,
      );
    }
  }

  _updatePicture(String originalPath, VideoEditorProcessingPictureModel model) {
    return _pictures.map((e) {
      if (e.originalPath == originalPath) {
        return model;
      }

      return e;
    }).toList();
  }

  VideoEditorProcessingPictureModel? _findPictureForOriginalPath(String path) {
    return _pictures.firstWhereOrNull((e) => e.originalPath == path);
  }

  _initPicture(String originalPath) async {
    final originalPicture = widget.pictures.firstWhereOrNull((e) => e.path == originalPath);
    if (originalPicture == null) return;

    final current = _pictures.firstWhereOrNull((e) => e.originalPath == originalPath);
    if (current != null) {
      CustomFileUtils.delete(current.picture.path);
    }

    final createdFiles = <String>[];

    deleteCreatedFiles() {
      for (var element in createdFiles) {
        CustomFileUtils.delete(element);
      }
      createdFiles.clear();
    }

    try {
      setState(() {
        _pictures = _updatePicture(
          originalPicture.path,
          VideoEditorProcessingPictureModel(
            picture: const CameraPictureFileModel(),
            originalPath: originalPicture.path,
            loading: true,
            error: null,
          ),
        );
      });

      final editedImagePath = await VideoEditorUtils.editImage(
        path: originalPicture.path,
        rotation: originalPicture.rotation,
        flipHorizontal: originalPicture.flipHorizontal,
        orderID: widget.orderID,
      );
      createdFiles.add(editedImagePath);

      final pictureSize = await VideoEditorUtils.getImageSize(editedImagePath, orderID: widget.orderID);
      final pictureLength = await File(editedImagePath).length();

      if (!mounted) {
        deleteCreatedFiles();
        return;
      }

      setState(() {
        _pictures = _updatePicture(
          originalPicture.path,
          VideoEditorProcessingPictureModel(
            picture: CameraPictureFileModel(
              size: pictureLength,
              height: pictureSize.height,
              width: pictureSize.width,
              path: editedImagePath,
            ),
            originalPath: originalPicture.path,
            loading: false,
            error: null,
          ),
        );
      });
    } catch (error, stack) {
      log("Error init picture", error: error, stackTrace: stack);
      if (!mounted) return;

      deleteCreatedFiles();

      final c = _findPictureForOriginalPath(originalPath);
      if (c != null) {
        CustomFileUtils.delete(c.picture.path);
      }

      setState(() {
        setState(() {
          _pictures = _updatePicture(
            originalPicture.path,
            VideoEditorProcessingPictureModel(
              picture: const CameraPictureFileModel(),
              originalPath: originalPicture.path,
              loading: false,
              error: error,
            ),
          );
        });
      });
    }
  }

  _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  _askClose() async {
    if (_processing) return;

    final exit = await showCustomDialog<bool>(
      title: "Exit",
      message: "Video and pictures will be lost. Are you sure?",
      buttonsBuilder: (context, controller) => [
        CustomBorderButton.small(
          text: "Cancel",
          onPressed: () => controller.close(result: false),
        ),
        CustomBorderButton.small(
          text: "Exit",
          borderColor: CustomColorsUtils.delete,
          textColor: CustomColorsUtils.delete,
          onPressed: () => controller.close(result: true),
        ),
      ],
    );
    if (exit != true) return;
    _close();
  }

  _close() {
    if (_processing) return;
    _deleteAll();
    Navigator.of(context).pop();
  }

  _onVideoPressed() {
    int page = 0;

    if (page != _currentPage) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  _onPicturePressed(VideoEditorProcessingPictureModel model) {
    final index = _pictures.indexWhere((e) => e.originalPath == model.originalPath);
    if (index == -1) return;

    int page = index + 1;

    if (page == _currentPage) {
      _showPictureOptions(index);
    } else {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  _showPictureOptions(int index) async {
    final delete = await showCustomDialog<bool>(
      title: "Delete image",
      message: "Are you sure?",
      buttonsBuilder: (c, controller) => [
        CustomBorderButton.small(
          text: "Cancel",
          onPressed: controller.close,
        ),
        CustomBorderButton.small(
          text: "Delete",
          textColor: CustomColorsUtils.delete,
          borderColor: CustomColorsUtils.delete,
          onPressed: () => controller.close(result: true),
        ),
      ],
    );
    if (delete != true) return;

    final newPictures = List<VideoEditorProcessingPictureModel>.from(_pictures);
    final model = newPictures.removeAt(index);
    CustomFileUtils.delete(model.picture.path);

    setState(() {
      _pictures = newPictures;
    });

    _pageController.animateToPage(
      _currentPage - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  _onButtonDonePressed() async {
    if (_video?.error != null) {
      await showCustomDialogRetry(
        title: "Error",
        message: "Please check the video",
      );
      return;
    }

    if (_pictures.any((e) => e.error != null)) {
      await showCustomDialogRetry(
        title: "Error",
        message: "Please check the pictures",
      );
      return;
    }

    final createdFiles = <String>[];

    try {
      setState(() {
        _processing = true;
      });

      final videoPath = await VideoEditorUtils.trimVideo(
        path: _video?.video.info.path ?? "",
        videoDuration: Duration(milliseconds: _video?.video.info.durationMillis ?? 0),
        startDuration: _startDuration,
        endDuration: _endDuration,
        orderID: widget.orderID,
      );
      createdFiles.add(videoPath);

      final videoInfo = await VideoEditorUtils.getVideoInfo(videoPath, orderID: widget.orderID);
      final thumbnail = await VideoEditorUtils.getVideoThumbnail(videoPath, orderID: widget.orderID);
      createdFiles.add(thumbnail);

      // Pictures
      var pictures = <CameraPictureFileModel>[];
      for (var element in _pictures) {
        final extension = element.picture.path.split(".").last;
        final path = await CustomFileUtils.generateTempImagePath(extension);

        // Copy file
        File(element.picture.path).copy(path);
        pictures.add(element.picture.copyWith(path: path));
        createdFiles.add(path);
      }

      if (!mounted) return;
      Navigator.of(context).pop(
        CameraResultModel(
          video: CameraVideoFileModel(
            info: videoInfo,
            thumbnailPath: thumbnail,
          ),
          pictures: pictures,
        ),
      );
    } catch (error, stack) {
      log("Error processing video", error: error, stackTrace: stack);
      if (!mounted) return;

      for (var element in createdFiles) {
        CustomFileUtils.delete(element);
      }

      setState(() {
        _processing = false;
      });
      final retry = await showCustomDialogRetry();
      if (retry) {
        _onButtonDonePressed();
      }
    }
  }

  _editImage(
    VideoEditorProcessingPictureModel model, {
    double angle = 0.0,
    bool flipHorizontal = false,
    bool flipVertical = false,
  }) async {
    if (model.picture.path.isEmpty) return;
    if (model.loading) return;
    if (model.error != null) return;

    final createdFiles = <String>[];

    deleteCreatedFiles() {
      for (var element in createdFiles) {
        CustomFileUtils.delete(element);
      }
    }

    try {
      setState(() {
        _pictures = _updatePicture(
          model.originalPath,
          model.copyWith(
            loading: true,
            error: null,
          ),
        );
      });

      final edited = await VideoEditorUtils.editImage(
        path: model.picture.path,
        rotation: angle,
        flipHorizontal: flipHorizontal,
        flipVertical: flipVertical,
        orderID: widget.orderID,
      );
      createdFiles.add(edited);

      final pictureSize = await VideoEditorUtils.getImageSize(edited, orderID: widget.orderID);
      final pictureLength = await File(edited).length();

      if (!mounted) {
        deleteCreatedFiles();
        return;
      }

      CustomFileUtils.delete(model.picture.path);

      setState(() {
        _pictures = _updatePicture(
          model.originalPath,
          model.copyWith(
            picture: CameraPictureFileModel(
              path: edited,
              width: pictureSize.width,
              height: pictureSize.height,
              size: pictureLength,
            ),
            loading: false,
          ),
        );
      });
    } catch (error) {
      log("Error editing image", error: error);
      if (!mounted) return;

      deleteCreatedFiles();

      final retry = await showCustomDialogRetry(error: error);
      if (retry) {
        _editImage(
          model,
          angle: angle,
          flipHorizontal: flipHorizontal,
          flipVertical: flipVertical,
        );
      } else {
        setState(() {
          _pictures = _updatePicture(
            model.originalPath,
            model.copyWith(
              loading: false,
              error: error,
            ),
          );
        });
      }
    }
  }

  bool get _isReady {
    if (_video?.loading == true) return false;
    if (_video?.error != null) return false;
    if (_pictures.any((e) => e.loading)) return false;
    if (_pictures.any((e) => e.error != null)) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final appBarIconColor = Theme.of(context).appBarTheme.backgroundColor?.contrast(context);

    return CustomScaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      onWillPop: () async {
        _askClose();
        return false;
      },
      appbar: CustomAppBar(
        backgroundColor: Colors.black,
        leading: CustomButtonIcon(
          enabled: !_processing,
          backgroundColor: Colors.transparent,
          icon: Icons.arrow_back_ios,
          iconColor: appBarIconColor,
          onPressed: _askClose,
        ),
        actionButtons: [
          CustomGradientButton.small(
            enabled: !_processing && _isReady,
            icon: Icons.check,
            gradient: CustomColorsUtils.gradient,
            text: "Done",
            onPressed: _onButtonDonePressed,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Content
          Positioned.fill(
            child: CustomAnimatedFadeVisibility(
              visible: !_processing,
              child: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
                color: Colors.black,
                child: Column(
                  children: [
                    Expanded(
                      child: ScreenCustomCameraVideoResultPagerContent(
                        onPageChanged: _onPageChanged,
                        controller: _pageController,
                        video: _video,
                        pictures: _pictures,
                        retryVideo: _initVideo,
                        retryPicture: (model) => _initPicture(model.originalPath),
                        onButtonRotateLeftPressed: (m) => _editImage(m, angle: -90),
                        onButtonRotateRightPressed: (m) => _editImage(m, angle: 90),
                        onButtonFlipHorizontalPressed: (m) => _editImage(m, flipHorizontal: true),
                        onButtonFlipVerticalPressed: (m) => _editImage(m, flipVertical: true),
                        onDurationStartChange: (start) => setState(() => _startDuration = start),
                        onDurationEndChange: (end) => setState(() => _endDuration = end),
                      ),
                    ),
                    CustomAnimatedCollapseVisibility(
                      visible: _pictures.isNotEmpty,
                      child: CustomFadingEdgeList(
                        color: Colors.black,
                        direction: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(16.0),
                          child: CustomCameraVideoResultPagerPreview(
                            currentPage: _currentPage,
                            video: _video,
                            pictures: _pictures,
                            onVideoPressed: _onVideoPressed,
                            onPicturePressed: _onPicturePressed,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Loading
          CustomAnimatedFadeVisibility(
            visible: _processing,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
