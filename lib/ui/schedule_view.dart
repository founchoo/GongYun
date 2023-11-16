import 'dart:math';

import 'package:gong_yun/api/chaoxing_service.dart';
import 'package:gong_yun/model/schedule.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _nodeSize = 5;
  final _daySize = 7;
  final _nodeTime = [
    // 上午
    [
      // 第一节课
      ['08:20', '09:05'],
      // 第二节课
      ['09:10', '09:55']
    ],
    [
      // 第三节课
      ['10:15', '11:00'],
      // 第四节课
      ['11:05', '11:50']
    ],
    // 下午
    [
      // 第五节课
      ['14:00', '14:45'],
      // 第六节课
      ['14:50', '15:35']
    ],
    [
      // 第七节课
      ['15:55', '16:40'],
      // 第八节课
      ['16:45', '17:30']
    ],
    // 晚上
    [
      // 第九节课
      ['18:30', '19:15'],
      // 第十节课
      ['19:20', '20:05']
    ],
  ];

  Map<(int, int), List<Schedule>>? _courses;

  Future<void> _loadData() async {
    final tmp = await ChaoxingService.getSchedule();
    Map<(int, int), List<Schedule>> result = {};
    for (var element in tmp) {
      if (element.node % 2 != 0) {
        continue;
      }
      element.node ~/= 2;
      final key = (element.dayOfWeek, element.node);
      if (result[key] == null) {
        result[key] = [];
      }
      result[key]!.add(element);
    }
    setState(() {
      _courses = result;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 表头元素（年份标识、星期标识）的高度
        const headerHeight = 40.0;
        // 节次元素的宽度
        const nodeWidth = 50.0;
        // 普通元素的宽度及高度
        var elementWidth = (constraints.maxWidth - nodeWidth) / _daySize;
        var elementHeight = (constraints.maxHeight - headerHeight) / _nodeSize;
        if (elementHeight * elementWidth < 50 * 120) {
          elementHeight = 50 * 120 / elementWidth;
        }
        elementHeight = max(90, elementHeight);
        return ListView(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: Row(
                children: [
                  // 年份标识
                  const Center(
                    child: SizedBox(
                      width: nodeWidth,
                      child: Center(
                        child: Text(
                          '23\n年',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 星期标识
                  for (var curDayIndex = 0;
                      curDayIndex < _daySize;
                      curDayIndex++)
                    SizedBox(
                      width: elementWidth,
                      child: Center(
                        child: Text('周${'一二三四五六日'[curDayIndex]}'),
                      ),
                    )
                ],
              ),
            ),
            // 课程表
            for (var curNodeIndex = 0;
                curNodeIndex < _nodeSize;
                curNodeIndex++) ...[
              Row(
                children: [
                  // 节数标识
                  SizedBox(
                    width: nodeWidth,
                    height: elementHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var curSubNode = 0; curSubNode < 2; curSubNode++)
                          Text(
                            '${curNodeIndex * 2 + curSubNode + 1}\n'
                            '${_nodeTime[curNodeIndex][curSubNode][0]}\n'
                            '${_nodeTime[curNodeIndex][curSubNode][1]}',
                            style: const TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          )
                      ],
                    ),
                  ),
                  // 课程
                  for (var curDayIndex = 0;
                      curDayIndex < _daySize;
                      curDayIndex++)
                    SizedBox(
                      width: elementWidth,
                      height: elementHeight,
                      child:
                          _courses?[(curDayIndex + 1, curNodeIndex + 1)]?.first != null
                              ? Card(
                                  child: Center(
                                    child: Text(
                                      '${_courses?[(
                                            curDayIndex + 1,
                                            curNodeIndex + 1
                                          )]?.first.courseName ?? ''}\n'
                                      '${_courses?[(
                                            curDayIndex + 1,
                                            curNodeIndex + 1
                                          )]?.first.courseLocation ?? ''}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : null,
                    )
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
