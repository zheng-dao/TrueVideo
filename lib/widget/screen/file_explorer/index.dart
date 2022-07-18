import 'dart:io';

import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/popup/controller.dart';
import 'package:truvideo_enterprise/widget/common/popup/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'file_dialog.dart';

enum _FileSort {
  name,
  date,
  size,
}

class ScreenFileExplorerParams {
  final String directory;
  CustomRouteType? routeType;

  ScreenFileExplorerParams({this.directory = "", this.routeType});
}

class ScreenFileExplorer extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenFileExplorer";
  final ScreenFileExplorerParams params;

  const ScreenFileExplorer({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenFileExplorer> createState() => _ScreenFileExplorerState();
}

class _ScreenFileExplorerState extends ConsumerState<ScreenFileExplorer> {
  var _directoryParts = <String>[];
  _FileSort _sort = _FileSort.name;
  bool _sortAscending = true;

  var _items = <_File>[];
  int? _totalSize;
  bool _loading = true;
  var _checked = <String>[];
  bool _selection = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _refresh());
  }

  _refresh() async {
    setState(() {
      _loading = true;
    });

    final documentsDirectory = await path.getApplicationDocumentsDirectory();

    Directory directory;
    List<String> directoryParts;
    if (widget.params.directory.trim().isEmpty) {
      directory = documentsDirectory;
      directoryParts = <String>[];
    } else {
      directory = Directory(widget.params.directory);
      directoryParts = directory.path.replaceAll(documentsDirectory.path, "").split("/").where((e) => e.trim().isNotEmpty).toList();
    }

    int totalSize = 0;
    directory.listSync(recursive: true, followLinks: false).whereType<File>().forEach((element) {
      totalSize += element.lengthSync();
    });

    final items = directory.listSync(recursive: false, followLinks: false).map((e) {
      int size = 0;
      if (e is Directory) {
        final directoryFiles = e.listSync(recursive: true, followLinks: false);
        directoryFiles.whereType<File>().forEach((element) {
          size += element.lengthSync();
        });
      } else {
        if (e is File) {
          size = e.lengthSync();
        }
      }

      return _File(
        isDirectory: e is Directory,
        name: e.path.split("/").last,
        size: size,
        path: e.path,
        date: e.statSync().modified,
      );
    }).toList();

    setState(() {
      _loading = false;
      _totalSize = totalSize;
      _items = items;
      _directoryParts = directoryParts;
    });
  }

  _close() {
    Navigator.of(context).pop();
  }

  _onItemLongPressed(_File file) {
    if (_selection) {
      return;
    }

    if (file.isDirectory) return;

    setState(() {
      _checked = [file.path];
      _selection = true;
    });
  }

  _onItemPressed(_File file) async {
    if (_selection) {
      if (file.isDirectory) return;

      var newSelection = <String>[];
      if (_checked.contains(file.path)) {
        newSelection = _checked.where((element) => element != file.path).toList();
      } else {
        newSelection = [
          ..._checked,
          file.path,
        ];
      }
      if (newSelection.isEmpty) {
        _cancelSelection();
      } else {
        setState(() {
          _checked = newSelection;
        });
      }
      return;
    }

    if (file.isDirectory) {
      await Navigator.of(context).pushNamed(
        ScreenFileExplorer.routeName,
        arguments: ScreenFileExplorerParams(directory: file.path),
      );
      _refresh();
      return;
    }

    showCustomDialog(
      title: "File details",
      childPadding: EdgeInsets.zero,
      builder: (context, controller) => FileDialogWidget(
        path: file.path,
        controller: controller,
        refresh: _refresh,
      ),
    );
  }

  _cancelSelection() {
    setState(() {
      _checked = [];
      _selection = false;
    });
  }

  _deleteSelection() async {
    final delete = await showCustomDialogRetry(
      title: "Delete files",
      message: "Are you sure you wan delete ${_checked.length} files?",
      retryButtonText: "Yes",
      cancelButtonText: "Cancel",
    );
    if (!delete) return;

    for (var element in _checked) {
      CustomFileUtils.delete(element);
    }
    _cancelSelection();
    _refresh();
  }

  _selectAll() {
    setState(() {
      _checked = _items.where((element) => !element.isDirectory).map((e) => e.path).toList();
    });
  }

  _onSortPressed() {
    showCustomPopup(
      right: 0,
      builder: (context, CustomPopupController controller) => Column(
        children: [
          CustomListTile(
            dense: true,
            titleText: "Sorting:",
            titleStyle: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.bold),
          ),
          CustomListTile(
            dense: true,
            titleText: "Name",
            trailing: Icon(
              _sort == _FileSort.name ? Icons.check_box_outlined : Icons.square_outlined,
              size: 15,
            ),
            onPressed: () {
              setState(() {
                _sort = _FileSort.name;
              });

              controller.refresh();
            },
          ),
          const CustomDivider(),
          CustomListTile(
            dense: true,
            titleText: "Date",
            trailing: Icon(
              _sort == _FileSort.date ? Icons.check_box_outlined : Icons.square_outlined,
              size: 15,
            ),
            onPressed: () {
              setState(() {
                _sort = _FileSort.date;
              });

              controller.refresh();
            },
          ),
          const CustomDivider(),
          CustomListTile(
            dense: true,
            titleText: "Size",
            trailing: Icon(
              _sort == _FileSort.size ? Icons.check_box_outlined : Icons.square_outlined,
              size: 15,
            ),
            onPressed: () {
              setState(() {
                _sort = _FileSort.size;
              });

              controller.refresh();
            },
          ),
          const CustomDivider(),
          CustomListTile(
            dense: true,
            titleText: "Ascending",
            trailing: Icon(
              _sortAscending ? Icons.check_circle_outline : Icons.circle_outlined,
              size: 15,
            ),
            onPressed: () {
              setState(() {
                _sortAscending = !_sortAscending;
              });

              controller.refresh();
            },
          ),
        ],
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

    final sortedItems = useMemoized(
      () {
        final dirs = _items.where((element) => element.isDirectory).toList();
        final files = _items.where((element) => !element.isDirectory).toList();

        int Function(_File a, _File b) sorting;

        switch (_sort) {
          case _FileSort.name:
            if (_sortAscending) {
              sorting = (a, b) => a.name.trim().toUpperCase().compareTo(b.name.trim().toUpperCase());
            } else {
              sorting = (a, b) => b.name.trim().toUpperCase().compareTo(a.name.trim().toUpperCase());
            }
            break;
          case _FileSort.date:
            if (_sortAscending) {
              sorting = (a, b) => a.date.compareTo(b.date);
            } else {
              sorting = (a, b) => b.date.compareTo(a.date);
            }
            break;
          case _FileSort.size:
            if (_sortAscending) {
              sorting = (a, b) => a.size.compareTo(b.size);
            } else {
              sorting = (a, b) => b.size.compareTo(a.size);
            }
            break;
        }

        dirs.sort(sorting);
        files.sort(sorting);

        return [
          ...dirs,
          ...files,
        ];
      },
      [_items, _sort, _sortAscending],
    );

    return CustomScaffold(
      resizeToAvoidBottomInset: false,
      appbar: CustomAppBar(
        backgroundColor: appBarFillColor,
        leading: isRouteTypeCupertinoVertical ? null : buttonClose,
        actionButtons: [
          CustomButtonIcon(
            onPressed: _onSortPressed,
            icon: Icons.sort,
            backgroundColor: Colors.transparent,
            iconColor: appBarIconColor,
          ),
          if (isRouteTypeCupertinoVertical) buttonClose,
        ],
        overlay: CustomAnimatedFadeVisibility(
          visible: _selection,
          child: CustomAppBar(
            backgroundColor: appBarFillColor,
            title: _checked.length.toString(),
            titleColor: appBarIconColor,
            leading: CustomButtonIcon(
              icon: Icons.clear,
              backgroundColor: Colors.transparent,
              iconColor: appBarIconColor,
              onPressed: _cancelSelection,
              tooltip: "Cancel selection",
            ),
            statusBar: false,
            actionButtons: [
              CustomButtonIcon(
                onPressed: _selectAll,
                icon: Icons.select_all,
                backgroundColor: Colors.transparent,
                iconColor: appBarIconColor,
                tooltip: "Select all",
              ),
              CustomButtonIcon(
                onPressed: _deleteSelection,
                icon: Icons.delete_outline,
                backgroundColor: Colors.transparent,
                iconColor: appBarIconColor,
                tooltip: "Delete selected",
              ),
            ],
          ),
        ),
        child: Transform.translate(
          offset: const Offset(-8.0, 0.0),
          child: CustomFadingEdgeList(
            direction: Axis.horizontal,
            color: appBarFillColor,
            child: SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "File explorer",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: appBarIconColor),
                    ),
                  ),
                  if (_directoryParts.isNotEmpty)
                    Icon(
                      Icons.chevron_right,
                      size: 15,
                      color: appBarIconColor,
                    ),
                  for (int i = 0; i < _directoryParts.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (i != 0)
                          Icon(
                            Icons.chevron_right,
                            size: 15,
                            color: appBarIconColor,
                          ),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _directoryParts[i],
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: appBarIconColor),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          CustomListTile(
            dense: true,
            color: Theme.of(context).dividerColor,
            titleText: _totalSize == null ? "" : "Total size: ${filesize(_totalSize ?? 0)}",
          ),
          Expanded(
            child: CustomFadingEdgeList(
              child: CustomList<_File>.separated(
                loading: _loading,
                controller: ModalScrollController.of(context),
                padding: const EdgeInsets.symmetric(vertical: 16).copyWith(bottom: 16 + MediaQuery.of(context).padding.bottom),
                data: sortedItems,
                areItemsTheSame: (a, b) => a.path == b.path,
                itemBuilder: (context, item) => CustomListTile(
                  key: ValueKey(item.path),
                  selected: _checked.contains(item.path),
                  titleText: item.path.split("/").last,
                  titleMaxLines: null,
                  trailingText: filesize(item.size),
                  subtitleMaxLines: null,
                  onPressed: () => _onItemPressed(item),
                  onLongPressed: () => _onItemLongPressed(item),
                  leading: CustomListTileImage(
                    icon: item.isDirectory ? Icons.folder : Icons.insert_drive_file_outlined,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _File {
  final bool isDirectory;
  final String name;
  final String path;
  final int size;
  final DateTime date;

  _File({
    this.isDirectory = false,
    this.name = "",
    this.path = "",
    required this.size,
    required this.date,
  });
}
