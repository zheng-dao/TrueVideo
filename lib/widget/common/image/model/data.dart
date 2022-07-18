import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'data_source_type.dart';

class CustomImageDataSource extends Equatable {
  final ImageProvider? imageProvider;
  final CustomImageDataSourceType type;
  final String data;
  final Uint8List? bytes;
  final BoxFit fit;
  final Color? color;

  const CustomImageDataSource({
    required this.type,
    this.imageProvider,
    this.data = "",
    this.bytes,
    this.fit = BoxFit.contain,
    this.color,
  });

  factory CustomImageDataSource.file(
    String path, {
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    return CustomImageDataSource(
      type: CustomImageDataSourceType.file,
      data: path,
      fit: fit,
      color: color,
    );
  }

  factory CustomImageDataSource.memory(
    Uint8List bytes, {
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    return CustomImageDataSource(
      type: CustomImageDataSourceType.memory,
      bytes: bytes,
      fit: fit,
      color: color,
    );
  }

  factory CustomImageDataSource.network(
    String url, {
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    return CustomImageDataSource(
      type: CustomImageDataSourceType.network,
      data: url,
      fit: fit,
      color: color,
    );
  }

  factory CustomImageDataSource.asset(
    String assetPath, {
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    return CustomImageDataSource(
      type: CustomImageDataSourceType.asset,
      data: assetPath,
      fit: fit,
      color: color,
    );
  }

  factory CustomImageDataSource.provider(
    ImageProvider imageProvider, {
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    return CustomImageDataSource(
      type: CustomImageDataSourceType.provider,
      imageProvider: imageProvider,
      fit: fit,
      color: color,
    );
  }

  @override
  List<Object?> get props => [
        type,
        data,
        bytes,
        fit,
        color,
      ];
}
