import 'package:equatable/equatable.dart';

class PaginationModel<T> extends Equatable {
  final List<T> data;
  final bool hasMore;
  final int total;
  final int page;
  final int pageSize;

  const PaginationModel({
    required this.data,
    this.hasMore = false,
    this.total = 0,
    this.page = 0,
    this.pageSize = 0,
  });

  @override
  List<Object?> get props => [data, hasMore, total, page, pageSize];
}
