import 'package:flutter/material.dart';
import 'package:gong_yun/api/chaoxing_service.dart';
import 'package:gong_yun/model/schedule.dart';
import 'package:pmvvm/pmvvm.dart';

class ScheduleViewModel extends ViewModel {
  final String pageName = '课表';

  Map<(int, int), List<Schedule>>? _backupCourses;

  Map<(int, int), List<Schedule>> courses = {};

  int _observedWeekNo = 1;
  int observedWeekNo = 1;
  final nodeSize = 5;
  final daySize = 7;
  final nodeTime = [
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
    _backupCourses = result;
    filterCourses();
  }

  void filterCourses() {
    courses = {};
    for (var element in _backupCourses!.entries) {
      if (courses[element.key] == null) {
        courses[element.key] = [];
      }
      final mixed = element.value.toList();
      final result =
          mixed.where((element) => element.isCurrentWeekCourse(observedWeekNo));
      if (result.isNotEmpty) {
        final add = result.first;
        mixed.remove(add);
        mixed.insert(0, add);
      }
      courses[element.key] = mixed;
    }
    notifyListeners();
  }

  void setObservedWeekNo(int value) {
    observedWeekNo = value;
    notifyListeners();
  }

  Future<void> showScheduleSwitchDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('切换课表'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('切换周数'),
                Slider(
                  value: _observedWeekNo.toDouble(),
                  min: 1.0,
                  max: 20.0,
                  divisions: 20,
                  onChanged: (double value) {
                    setState(() {
                      _observedWeekNo = value.toInt();
                    });
                  },
                  label: _observedWeekNo.toString(),
                ),
                const SizedBox(height: 8),
                const Text('切换学期'),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('确认'),
                onPressed: () {
                  observedWeekNo = _observedWeekNo;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
    filterCourses();
  }

  @override
  init() async {
    await _loadData();
  }
}
