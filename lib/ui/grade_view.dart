import 'package:flutter/material.dart';
import 'package:gong_yun/view_model/grade_view_model.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';

class GradePage extends StatelessWidget {
  final GradeViewModel viewModel;

  const GradePage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM<GradeViewModel>(
      view: () => _GradeView(),
      viewModel: viewModel,
    );
  }
}

class _GradeView extends HookView<GradeViewModel> {
  Widget _buildSimpleTextPlaceholder(int count, double width) {
    return SizedBox(
      width: width,
      child: PlaceholderLines(
        count: count,
        animate: true,
        lineHeight: 14,
      ),
    );
  }

  @override
  Widget render(BuildContext context, GradeViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.pageName),
        forceMaterialTransparency: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.translate),
                        const Text('已筛选课程成绩'),
                        if (viewModel.grades.isEmpty)
                          _buildSimpleTextPlaceholder(2, 100)
                        else ...[
                          Text('平均学分绩点 ${viewModel.gpa.toStringAsFixed(4)}'),
                          Text(
                              '算数平均分 ${viewModel.averageScore.toStringAsFixed(4)}')
                        ],
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.groups),
                        const Text('排名信息'),
                        if (viewModel.rankingInfo.byGPAByClass == null)
                          _buildSimpleTextPlaceholder(2, 400)
                        else ...[
                          Text('平均学分绩点排名 '
                              '年级 ${viewModel.rankingInfo.byGPAByInstitute?.rank}/'
                              '${viewModel.rankingInfo.byGPAByInstitute?.total} '
                              '专业 ${viewModel.rankingInfo.byGPAByMajor?.rank}/'
                              '${viewModel.rankingInfo.byGPAByMajor?.total} '
                              '班级 ${viewModel.rankingInfo.byGPAByClass?.rank}/'
                              '${viewModel.rankingInfo.byGPAByClass?.total}'),
                          Text('算术平均分排名 '
                              '年级 ${viewModel.rankingInfo.byScoreByInstitute?.rank}/'
                              '${viewModel.rankingInfo.byScoreByInstitute?.total} '
                              '专业 ${viewModel.rankingInfo.byScoreByMajor?.rank}/'
                              '${viewModel.rankingInfo.byScoreByMajor?.total} '
                              '班级 ${viewModel.rankingInfo.byScoreByClass?.rank}/'
                              '${viewModel.rankingInfo.byScoreByClass?.total}')
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (var i = 0; i < viewModel.grades.length; i++) ...[
                  ListTile(
                    title: Text(viewModel.grades[i].getPureCourseName()),
                    subtitle: Text('分数 ${viewModel.grades[i].score}'),
                    trailing: Text('学分 ${viewModel.grades[i].credit}'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(viewModel.grades[i].getPureCourseName()),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '学年学期 ${viewModel.grades[i].semesterYearAndNo}'),
                              Text('课程性质 ${viewModel.grades[i].courseProperty}'),
                              Text('课程编号 ${viewModel.grades[i].courseId}'),
                              Text('成绩详情 ${viewModel.grades[i].detail}'),
                              Text('学分绩点 ${viewModel.grades[i].gradePoint}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => {Navigator.pop(context)},
                              child: const Text('关闭'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
