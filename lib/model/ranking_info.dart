class RankingInfo {
  RankingItem? byGPAByInstitute;
  RankingItem? byGPAByMajor;
  RankingItem? byGPAByClass;

  RankingItem? byScoreByInstitute;
  RankingItem? byScoreByMajor;
  RankingItem? byScoreByClass;

  RankingInfo({
    this.byGPAByInstitute,
    this.byGPAByMajor,
    this.byGPAByClass,
    this.byScoreByInstitute,
    this.byScoreByMajor,
    this.byScoreByClass,
  });
}

class RankingItem {
  final int total;
  final int rank;

  RankingItem({
    required this.total,
    required this.rank,
  });
}
