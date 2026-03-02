class SearchPaginationParams {
  final int pageNo;
  final int pageSize;
  final String? query;

  SearchPaginationParams({
    required this.pageNo,
    required this.pageSize,
    required this.query,
  });
}
