import 'package:gong_yun/api/chaoxing_service.dart';
import 'package:gong_yun/model/grade_response.dart';
import 'package:gong_yun/model/ranking_info.dart';
import 'package:pmvvm/pmvvm.dart';

class GradeViewModel extends ViewModel {
  final String pageName = '成绩';

  List<Grade> grades = [];
  RankingInfo rankingInfo = RankingInfo();
  double gpa = 0.0;
  double averageScore = 0.0;

  Future getGrade() async {
    grades = await ChaoxingService.getGrade();
    gpa =
        grades.map((e) => e.gradePoint * e.creditGain).reduce((a, b) => a + b) /
            grades.map((e) => e.creditGain).reduce((a, b) => a + b);
    averageScore =
        grades.map((e) => int.parse(e.score)).reduce((a, b) => a + b) /
            grades.length;
    notifyListeners();
  }

  Future getRankingInfo() async {
    rankingInfo = await ChaoxingService.getRankingInfo([]);
    notifyListeners();
  }

  @override
  void init() async {
    await getGrade();
    await getRankingInfo();
  }
}
