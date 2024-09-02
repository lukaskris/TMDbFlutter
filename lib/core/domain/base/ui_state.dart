// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UiState<T> extends Equatable {
  const UiState(
      {this.isLoading = true,
      this.isLoadMore = false,
      this.isMaximum = false,
      this.offset = 0,
      this.limit = 20,
      this.errorMessage = '',
      this.data});

  final bool isLoading;
  final bool isLoadMore;
  final bool isMaximum;
  final int offset;
  final int limit;
  final String errorMessage;
  final T? data;

  @override
  List<Object?> get props =>
      [isLoading, isLoadMore, offset, limit, data, errorMessage];

  UiState<T> copyWith({
    bool? isLoading,
    bool? isLoadMore,
    bool? isMaximum,
    int? offset,
    int? limit,
    String? errorMessage,
    T? data,
  }) {
    return UiState<T>(
      isLoading: isLoading ?? this.isLoading,
      isMaximum: isMaximum ?? this.isMaximum,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
