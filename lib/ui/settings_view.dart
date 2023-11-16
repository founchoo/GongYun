import 'package:gong_yun/constant.dart';
import 'package:gong_yun/view_model/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return MVVM<SettingsViewModel>(
      view: () => _SettingsView(),
      viewModel: SettingsViewModel(),
    );
  }
}

class _SettingsView extends HookView<SettingsViewModel> {
  const _SettingsView({Key? key}) : super(key: key, reactive: true);

  @override
  Widget render(BuildContext context, SettingsViewModel viewModel) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '账户',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.account_circle_outlined),
          title: Text(viewModel.isLogin ? '登出' : '登录'),
          subtitle: Text(viewModel.isLogin ? '欢迎 1234567890' : '请先登录'),
          onTap: () => {
            viewModel.isLogin == false
                ? showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('登录'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: '学号',
                                ),
                                controller: viewModel.studentIdController,
                              ),
                              TextField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: '密码',
                                ),
                                controller: viewModel.passwordController,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => {Navigator.pop(context)},
                              child: const Text('取消'),
                            ),
                            TextButton(
                              onPressed: () async => {await viewModel.login()},
                              child: const Text('登录'),
                            ),
                          ],
                        ))
                : viewModel.logout()
          },
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '课表',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.do_not_disturb_on_outlined),
          title: const Text('显示非本周课程'),
          subtitle: const Text('以更高的透明度显示非本周课程'),
          value: viewModel.isShowNonCurrentWeek,
          onChanged: (bool value) {
            viewModel.setIsShowNonCurrentWeek(value);
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.calendar_view_day_outlined),
          title: const Text('显示年份'),
          subtitle: const Text('在左上角显示当前展示周数所属年份'),
          value: viewModel.isShowYear,
          onChanged: (bool value) {
            viewModel.setIsShowYear(value);
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.today_outlined),
          title: const Text('显示日期'),
          subtitle: const Text('在星期下方显示对应日期'),
          value: viewModel.isShowDate,
          onChanged: (bool value) {
            viewModel.setIsShowDate(value);
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.schedule_outlined),
          title: const Text('显示时间段'),
          subtitle: const Text('在节次下方显示上课时间段'),
          value: viewModel.isShowTime,
          onChanged: (bool value) {
            viewModel.setIsShowTime(value);
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.schedule_outlined),
          title: const Text('（实验性）固定课程到桌面'),
          subtitle: const Text('请确保已授予"桌面快捷方式"权限'),
          value: viewModel.isShowDesktopShortcut,
          onChanged: (bool value) {
            viewModel.setIsShowDesktopShortcut(value);
          },
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '主题',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.color_lens_outlined),
          title: const Text('系统主题色'),
          subtitle: const Text('开启后将跟随系统主题色'),
          value: viewModel.isSysColor,
          onChanged: (bool value) {
            viewModel.setIsSysColor(value);
          },
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: const Text('深色主题'),
          trailing: DropdownButton<String>(
            style: Theme.of(context).textTheme.bodyMedium,
            underline: Container(),
            icon: Container(),
            value: viewModel.darkMode,
            onChanged: (String? value) {
              viewModel.setDarkMode(value!);
            },
            items: <String>['跟随系统', '开启', '关闭'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '关于',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        const AboutListTile(
          icon: Icon(Icons.info_outline),
          applicationName: appName,
          applicationVersion: '1.0.0',
        ),
        ListTile(
          leading: const Icon(Icons.feedback_outlined),
          title: const Text('反馈'),
          subtitle: const Text('加入群聊提供你的意见及反馈'),
          onTap: () => {},
        ),
        ListTile(
          leading: const Icon(Icons.code_outlined),
          title: const Text('开源代码'),
          subtitle: const Text('你的开发将为此应用贡献一份力量'),
          onTap: () => {},
        )
      ],
    );
  }
}
