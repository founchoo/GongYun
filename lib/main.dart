import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gong_yun/api/data_storage_service.dart';
import 'package:gong_yun/constant.dart';
import 'package:gong_yun/main_view_model.dart';
import 'package:gong_yun/ui/grade_view.dart';
import 'package:gong_yun/ui/schedule_view.dart';
import 'package:gong_yun/ui/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:gong_yun/view_model/grade_view_model.dart';
import 'package:gong_yun/view_model/schedule_view_model.dart';
import 'package:gong_yun/view_model/settings_view_model.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:window_manager/window_manager.dart';

class Destination {
  const Destination(this.title, this.icon, this.selectedIcon);

  final String title;
  final IconData icon;
  final IconData selectedIcon;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataStorage.initSharedPrefs();

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await mainViewModel.detectLargeScreenMode();
    });
  }

  runApp(MainPage(mainViewModel));
}

// Fictitious brand color.
const _brandBlue = Color(0xFF1848AF);

MainViewModel mainViewModel = MainViewModel();

class MainPage extends StatelessWidget {
  final MainViewModel viewModel;

  const MainPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM<MainViewModel>(
      view: () => _MainView(),
      viewModel: viewModel,
    );
  }
}

class _MainView extends HookView<MainViewModel> {

  List<Destination> _getDestinations(
      BuildContext context, MainViewModel viewModel) {
    return <Destination>[
      const Destination('课表', Icons.schedule_outlined, Icons.schedule),
      const Destination('成绩', Icons.grade_outlined, Icons.grade),
      const Destination('设置', Icons.settings_outlined, Icons.settings),
    ];
  }

  List<Widget> _getNavDrawerChildren(
      BuildContext context, MainViewModel viewModel) {
    return _getDestinations(context, viewModel).map((Destination destination) {
      return NavigationDrawerDestination(
        icon: Icon(destination.icon),
        selectedIcon: Icon(destination.selectedIcon),
        label: Text(destination.title),
      );
    }).toList();
  }

  AppBar _buildWindowsAppBar(BuildContext context, MainViewModel viewModel) {
    return AppBar(
      forceMaterialTransparency: true,
      title: DragToMoveArea(
        child: SizedBox(
          width: double.infinity,
          height: kToolbarHeight,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewModel.isLargeScreenMode)
                  Text(
                    appName,
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontSize: 14),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            windowManager.minimize();
          },
          icon: const Icon(Icons.remove_outlined),
        ),
        IconButton(
          onPressed: () async {
            if (await windowManager.isMaximized()) {
              await windowManager.unmaximize();
            } else {
              await windowManager.maximize();
            }
          },
          icon: const Icon(Icons.crop_square_outlined),
        ),
        IconButton(
          onPressed: () {
            windowManager.close();
          },
          icon: const Icon(Icons.close_outlined),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _switchSelectedPage(MainViewModel viewModel) {
    switch (viewModel.selectedIndex) {
      case 0:
        return SchedulePage(ScheduleViewModel());
      case 1:
        return GradePage(GradeViewModel());
      case 2:
        return SettingsPage(SettingsViewModel());
      default:
        throw Exception('Invalid index');
    }
  }

  @override
  Widget render(BuildContext context, MainViewModel viewModel) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null &&
            darkDynamic != null &&
            viewModel.isSysColor) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          ),
          themeMode: [
            if (viewModel.darkMode == '跟随系统')
              ThemeMode.system
            else if (viewModel.darkMode == '开启')
              ThemeMode.dark
            else
              ThemeMode.light
          ][0],
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).colorScheme.background,
              systemNavigationBarColor:
                  Theme.of(context).colorScheme.background,
            ),
            child: Scaffold(
              appBar: [
                if (Platform.isWindows)
                  _buildWindowsAppBar(context, viewModel)
                else
                  null
              ][0],
              body: Row(
                children: [
                  if (viewModel.isLargeScreenMode)
                    NavigationDrawer(
                      elevation: 0,
                      selectedIndex: viewModel.selectedIndex,
                      onDestinationSelected: (int index) {
                        viewModel.setSelectedIndex(index);
                      },
                      children: _getNavDrawerChildren(context, viewModel),
                    ),
                  Flexible(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 1000,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _switchSelectedPage(viewModel),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: [
                if (viewModel.isLargeScreenMode)
                  null
                else
                  BottomNavigationBar(
                    currentIndex: viewModel.selectedIndex,
                    onTap: (int index) {
                      viewModel.setSelectedIndex(index);
                    },
                    items: _getDestinations(context, viewModel).map(
                      (Destination destination) {
                        return BottomNavigationBarItem(
                          icon: Icon(destination.icon),
                          activeIcon: Icon(destination.selectedIcon),
                          label: destination.title,
                        );
                      },
                    ).toList(),
                  )
              ][0],
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
