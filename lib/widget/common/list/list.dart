import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_empty.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_loading.dart';

import 'indicator_error.dart';
import 'list_item_animation.dart';
import 'load_more.dart';

enum CustomListStatus {
  loading,
  error,
  empty,
  data,
}

class CustomList<T extends Object> extends StatefulWidget {
  final bool shrinkWrap;
  final List<T>? data;
  final bool loading;
  final bool loadingMore;
  final dynamic error;
  final dynamic loadingMoreError;
  final EdgeInsets? padding;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget Function(BuildContext context)? emptyBuilder;
  final Widget Function(BuildContext context, dynamic error)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final bool Function(List<T> data)? isEmpty;
  final bool Function()? isError;
  final bool Function()? isLoading;
  final bool reverse;
  final Function(BuildContext context)? separatorBuilder;
  final Function()? loadMore;
  final bool showLoadMore;
  final Widget? header;
  final Widget? footer;
  final bool Function(CustomListStatus status)? headerVisibility;
  final bool Function(CustomListStatus status)? footerVisibility;
  final ScrollPhysics? scrollPhysics;
  final bool withSeparator;
  final bool Function(T a, T b) areItemsTheSame;
  final Widget Function(BuildContext context, Widget child)? listWrapper;
  final ScrollController? controller;
  final bool animated;

  const CustomList({
    Key? key,
    this.data,
    this.loading = false,
    this.error,
    this.padding,
    required this.itemBuilder,
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.isEmpty,
    this.reverse = false,
    this.isError,
    this.isLoading,
    this.loadMore,
    this.showLoadMore = false,
    this.header,
    this.footer,
    this.loadingMoreError,
    this.headerVisibility,
    this.footerVisibility,
    this.shrinkWrap = false,
    this.scrollPhysics,
    this.withSeparator = false,
    required this.areItemsTheSame,
    this.listWrapper,
    this.controller,
    this.animated = true,
    this.loadingMore = false,
  })  : separatorBuilder = null,
        super(key: key);

  const CustomList.separated({
    Key? key,
    this.data,
    this.loading = false,
    this.error,
    this.padding,
    required this.itemBuilder,
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.isEmpty,
    this.reverse = false,
    this.separatorBuilder,
    this.isError,
    this.isLoading,
    this.loadMore,
    this.showLoadMore = false,
    this.header,
    this.footer,
    this.loadingMoreError,
    this.headerVisibility,
    this.footerVisibility,
    this.shrinkWrap = false,
    this.scrollPhysics,
    this.withSeparator = true,
    required this.areItemsTheSame,
    this.listWrapper,
    this.controller,
    this.animated = true,
    this.loadingMore = false,
  }) : super(key: key);

  @override
  State<CustomList<T>> createState() => _CustomListState<T>();
}

class _CustomListState<T extends Object> extends State<CustomList<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }

    super.dispose();
  }

  _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final pos = _scrollController.position.pixels;
    final dif = pos - max;
    if (dif < 30) {
      EasyDebounce.debounce(
        "searchMore",
        const Duration(milliseconds: 300),
        _fetchMore,
      );
    }
  }

  bool _processing = false;

  _fetchMore() async {
    if (!widget.showLoadMore) return;
    if (widget.loadingMore) return;
    if (widget.loadingMoreError != null) return;
    if (_processing) return;

    try {
      _processing = true;
      await widget.loadMore?.call();
      if (!mounted) return;
      _processing = false;
    } catch (_) {
      _processing = false;
    }
  }

  CustomListStatus get _status {
    if (_isLoading) return CustomListStatus.loading;
    if (_isError) return CustomListStatus.error;
    if (_isEmpty) return CustomListStatus.empty;
    return CustomListStatus.data;
  }

  int get _length {
    if (widget.data == null) return 0;
    return widget.data!.length;
  }

  bool get _isEmpty {
    return widget.isEmpty?.call(widget.data ?? []) ?? _length == 0;
  }

  bool get _isLoading {
    return widget.isLoading?.call() ?? widget.loading;
  }

  bool get _isError {
    return widget.isError?.call() ?? widget.error != null;
  }

  Widget _buildContent(BuildContext context) {
    Widget content;
    switch (_status) {
      case CustomListStatus.loading:
        content = _buildLoading(context);
        break;
      case CustomListStatus.error:
        content = _buildError(context);
        break;
      case CustomListStatus.empty:
        content = _buildEmpty(context);
        break;
      case CustomListStatus.data:
        content = _buildList(context);
        break;
    }

    return content;
  }

  Widget _buildListWrapper(BuildContext context, {required Widget child}) {
    if (widget.listWrapper != null) {
      return widget.listWrapper!.call(context, child);
    }

    return child;
  }

  Widget _buildList(BuildContext context) {
    Widget buildItem(T item, int index) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.reverse && widget.withSeparator && index != 0) widget.separatorBuilder?.call(context) ?? const CustomDivider(),
          widget.itemBuilder(context, item),
          if (widget.reverse && widget.withSeparator && index != 0) widget.separatorBuilder?.call(context) ?? const CustomDivider(),
        ],
      );
    }

    Widget loadMoreWidget = CustomListLoadMore(
      error: widget.loadingMoreError,
      onRetryPressed: widget.loadMore,
    );

    Widget child;
    if (widget.animated) {
      child = ImplicitlyAnimatedList<Object>(
        controller: _scrollController,
        physics: widget.scrollPhysics,
        insertDuration: const Duration(milliseconds: 300),
        updateDuration: const Duration(milliseconds: 300),
        removeDuration: const Duration(milliseconds: 300),
        items: [
          ...(widget.data ?? <T>[]),
          if (widget.showLoadMore) "",
        ],
        areItemsTheSame: (a, b) {
          if (a is T && b is T) {
            return widget.areItemsTheSame(a, b);
          }

          return a == b;
        },
        itemBuilder: (context, animation, item, index) {
          if (item == "") return loadMoreWidget;
          if (item is! T) return Container(key: ValueKey(index));

          return CustomAnimatedListItem(
            key: ValueKey(index),
            animation: animation,
            axis: Axis.vertical,
            child: buildItem(item, index),
          );
        },
        spawnIsolate: false,
        reverse: widget.reverse,
        shrinkWrap: widget.shrinkWrap,
        padding: widget.padding,
      );
    } else {
      child = ListView.builder(
        controller: _scrollController,
        physics: widget.scrollPhysics,
        reverse: widget.reverse,
        shrinkWrap: widget.shrinkWrap,
        padding: widget.padding,
        itemCount: _length + (widget.showLoadMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (widget.showLoadMore && index == _length) return loadMoreWidget;

          final item = (widget.data ?? [])[index];

          return Column(
            key: ValueKey(index),
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!widget.reverse && widget.withSeparator && index != 0) widget.separatorBuilder?.call(context) ?? const CustomDivider(),
              widget.itemBuilder(context, item),
              if (widget.reverse && widget.withSeparator && index != 0) widget.separatorBuilder?.call(context) ?? const CustomDivider(),
            ],
          );
        },
      );
    }

    return _buildListWrapper(context, child: child);
  }

  Widget _buildLoading(BuildContext context) => Container(
        key: const ValueKey("loading"),
        color: Colors.transparent,
        alignment: Alignment.center,
        child: widget.loadingBuilder?.call(context) ?? const CustomListIndicatorLoading(),
      );

  Widget _buildError(BuildContext context) => LayoutBuilder(
        key: const ValueKey("error"),
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: widget.errorBuilder?.call(context, widget.error) ?? const CustomListIndicatorError(),
            ),
          );
        },
      );

  Widget _buildEmpty(BuildContext context) => LayoutBuilder(
        key: const ValueKey("empty"),
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: widget.emptyBuilder?.call(context) ?? const CustomListIndicatorEmpty(),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final headerVisible = widget.headerVisibility?.call(_status) ?? true;
    final footerVisible = widget.footerVisibility?.call(_status) ?? true;
    final currentHeader = headerVisible ? widget.header : null;
    final currentFooter = footerVisible ? widget.footer : null;

    final child = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Column(
        mainAxisSize: widget.shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
        key: ValueKey("${currentHeader != null}_${currentFooter != null}"),
        children: [
          if (currentHeader != null) currentHeader,
          Flexible(
            fit: widget.shrinkWrap ? FlexFit.loose : FlexFit.tight,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildContent(context),
            ),
          ),
          if (currentFooter != null) currentFooter,
        ],
      ),
    );

    return CustomAnimatedSwitcher(child: child);
  }
}
