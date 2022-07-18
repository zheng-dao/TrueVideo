import 'package:equatable/equatable.dart';

class CustomVideoPlayerDataSource extends Equatable {
  final String data;
  final bool isFile;

  const CustomVideoPlayerDataSource({
    this.data = "",
    this.isFile = false,
  });

  factory CustomVideoPlayerDataSource.file(String path) {
    return CustomVideoPlayerDataSource(
      data: path,
      isFile: true,
    );
  }

  factory CustomVideoPlayerDataSource.network(String url) {
    return CustomVideoPlayerDataSource(
      data: url,
      isFile: false,
    );
  }

  @override
  List<Object?> get props => [data, isFile];
}
