import 'dart:io';

import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';

class FileInfoWidget extends HookConsumerWidget {
  final String path;

  const FileInfoWidget({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateService dateService = GetIt.I.get();
    final stats = useMemoized(() => File(path).statSync());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Info(
            title: "Path",
            value: path,
          ),
          const SizedBox(height: 4.0),
          _Info(
            title: "Size",
            value: filesize(stats.size),
          ),
          const SizedBox(height: 4.0),
          _Info(
            title: "Accessed",
            value: dateService.formatDateTime(stats.accessed),
          ),
          const SizedBox(height: 4.0),
          _Info(
            title: "Modified",
            value: dateService.formatDateTime(stats.modified),
          ),
          const SizedBox(height: 4.0),
          _Info(
            title: "Changed",
            value: dateService.formatDateTime(stats.changed),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String title;
  final String value;

  const _Info({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SelectableText(value),
      ],
    );
  }
}
