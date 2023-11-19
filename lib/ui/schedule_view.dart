import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gong_yun/view_model/schedule_view_model.dart';
import 'package:pmvvm/pmvvm.dart';

class SchedulePage extends StatelessWidget {
  final ScheduleViewModel viewModel;

  const SchedulePage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM<ScheduleViewModel>(
      view: () => _ScheduleView(),
      viewModel: viewModel,
    );
  }
}

class _ScheduleView extends HookView<ScheduleViewModel> {
  @override
  Widget render(BuildContext context, ScheduleViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(viewModel.pageName),
            IconButton(
                onPressed: () async {
                  await viewModel.showScheduleSwitchDialog();
                },
                icon: const Icon(Icons.tune_outlined)),
          ],
        ),
        forceMaterialTransparency: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // 表头元素（年份标识、星期标识）的高度
          const headerHeight = 40.0;
          // 节次元素的宽度
          const nodeWidth = 50.0;
          // 普通元素的宽度及高度
          var elementWidth =
              (constraints.maxWidth - nodeWidth) / viewModel.daySize;
          var elementHeight =
              (constraints.maxHeight - headerHeight) / viewModel.nodeSize;
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
                        curDayIndex < viewModel.daySize;
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
                  curNodeIndex < viewModel.nodeSize;
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
                              '${viewModel.nodeTime[curNodeIndex][curSubNode][0]}\n'
                              '${viewModel.nodeTime[curNodeIndex][curSubNode][1]}',
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            )
                        ],
                      ),
                    ),
                    // 课程
                    for (var curDayIndex = 0;
                        curDayIndex < viewModel.daySize;
                        curDayIndex++)
                      SizedBox(
                        width: elementWidth,
                        height: elementHeight,
                        child: Builder(
                          builder: (context) {
                            if (viewModel
                                    .courses[(
                                  curDayIndex + 1,
                                  curNodeIndex + 1
                                )]
                                    ?.first !=
                                null) {
                              final course = viewModel
                                  .courses[(curDayIndex + 1, curNodeIndex + 1)]!
                                  .first;
                              return Card(
                                shadowColor: Colors.transparent,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer
                                    .withOpacity(course
                                        .getOpacity(viewModel.observedWeekNo)),
                                child: Center(
                                  child: Text(
                                    '${course.courseName ?? ''}\n'
                                    '${course.courseLocation ?? ''}',
                                    textAlign: TextAlign.center,
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(
                                            color: DefaultTextStyle.of(context)
                                                .style
                                                .color!
                                                .withOpacity(course.getOpacity(
                                                    viewModel.observedWeekNo))),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
