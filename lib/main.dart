import 'dart:io';

import 'package:gong_yun/api/data_storage_service.dart';
import 'package:gong_yun/constant.dart';
import 'package:gong_yun/ui/grade_view.dart';
import 'package:gong_yun/ui/schedule_view.dart';
import 'package:gong_yun/ui/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:window_manager/window_manager.dart';

class Destination {
  const Destination(this.title, this.icon, this.selectedIcon);

  final String title;
  final IconData icon;
  final IconData selectedIcon;
}

void main() async {
  await DataStorage.initSharedPrefs();
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const MyApp());
}

// Fictitious brand color.
const _brandBlue = Color(0xFF1848AF);

class MyApp extends StatelessWidget with WindowListener {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp with a DynamicColorBuilder.
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          // On Android S+ devices, use the provided dynamic color scheme.
          // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
          lightColorScheme = lightDynamic.harmonized();

          // Repeat for the dark color scheme.
          darkColorScheme = darkDynamic.harmonized();
        } else {
          // Otherwise, use fallback schemes.
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: appName,
          theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          ),
          home: const RootPage(title: appName),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.title});

  final String title;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with WindowListener {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.selected;
  double groupAlignment = 0.0;

  bool busy = false;
  String busyReason = '';

  late bool showNavigationDrawer;

  var destinations = const <Destination>[
    Destination('课表', Icons.schedule_outlined, Icons.schedule),
    Destination('成绩', Icons.grade_outlined, Icons.grade),
    Destination('设置', Icons.settings_outlined, Icons.settings),
  ];

  void callback(bool show, String text) {
    setState(() {
      busy = show;
      busyReason = text;
    });
  }

  List<Widget> getNavDrawerChildren() {
    var list = destinations.map((Destination destination) {
      return NavigationDrawerDestination(
        icon: Icon(destination.icon),
        selectedIcon: Icon(destination.selectedIcon),
        label: Text(destination.title),
      ) as Widget;
    }).toList();
    list.insert(
      0,
      DragToMoveArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            appName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
    return list;
  }

  Widget switchSelectedPage(int index) {
    switch (index) {
      case 0:
        return const SchedulePage();
      case 1:
        return const GradePage();
      case 2:
        return const SettingsPage();
      default:
        return const SettingsPage();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 845;
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  void _init() async {
    // 添加此行以覆盖默认关闭处理程序
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            body: Row(
              children: [
                if (showNavigationDrawer)
                  NavigationDrawer(
                    indicatorShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    tilePadding: EdgeInsets.zero,
                    elevation: 0,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: getNavDrawerChildren(),
                  ),
                Expanded(
                  child: Scaffold(
                    appBar: Platform.isWindows
                        ? AppBar(
                            title: DragToMoveArea(
                              child: SizedBox(
                                width: double.infinity,
                                height: kToolbarHeight,
                                child: showNavigationDrawer
                                    ? null
                                    : Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 16, 0, 0),
                                        child: const Text(appName),
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
                                    windowManager.unmaximize();
                                  } else {
                                    windowManager.maximize();
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
                          )
                        : (Platform.isAndroid
                            ? AppBar(
                                title: Text(destinations[_selectedIndex].title))
                            : null),
                    body: switchSelectedPage(_selectedIndex),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: showNavigationDrawer
                ? null
                : BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    onTap: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    items: destinations.map((Destination destination) {
                      return BottomNavigationBarItem(
                        icon: Icon(destination.icon),
                        activeIcon: Icon(destination.selectedIcon),
                        label: destination.title,
                      );
                    }).toList()),
          ),
          if (busy)
            const ModalBarrier(
              dismissible: false,
              color: Colors.black54,
            ),
          if (busy)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text(busyReason),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('退出应用'),
            content: const Text('确认退出应用吗？'),
            actions: [
              TextButton(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('确认'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
