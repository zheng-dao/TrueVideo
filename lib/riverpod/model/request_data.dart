import 'package:equatable/equatable.dart';

class RequestData<T extends Object> extends Equatable {
  final bool loading;
  final T? data;
  final dynamic error;

  const RequestData({
    this.loading = false,
    this.data,
    this.error,
  });

  copyWith({
    bool? loading,
    T? data,
    dynamic error,
  }) {
    return RequestData<T>(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [loading, data, error];
}
