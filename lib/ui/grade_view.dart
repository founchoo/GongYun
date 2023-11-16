import 'package:flutter/material.dart';

class GradePage extends StatefulWidget {
  const GradePage({Key? key}) : super(key: key);

  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SingleChildScrollView(
          padding: EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.translate),
                      Text('已筛选课程成绩'),
                      Text('平均学分绩点 4.2344'),
                      Text('平均学分绩点 93.79'),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.groups),
                      Text('排名信息'),
                      Text('平均学分绩点排名 年级 11/277 专业 6/55 班级 3/30'),
                      Text('算数平均分排名 年级 11/277 专业 7/55 班级 4/30'),
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
              for (var i = 0; i < 20; i++) ...[
                ListTile(
                  title: Text('高速退学${i}'),
                  subtitle: Text('分数 ${100 - i}'),
                ),
                const Divider(),
              ],
            ],
          ),
        )
      ],
    );
  }
}
