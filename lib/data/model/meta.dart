class Meta {
  final int totalCount;
  final int pageableCount;
  final bool isEnd;

  Meta({required this.totalCount, required this.pageableCount, required this.isEnd});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      totalCount: json['total_count'],
      pageableCount: json['pageable_count'],
      isEnd: json['is_end'],
      );
  }

  @override
  String toString() {
    return 'totalCount: $totalCount, pageableCount: $pageableCount, isEnd: $isEnd';
  }
}
