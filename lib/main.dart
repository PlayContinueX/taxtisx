import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:taxtisx/models/sidenavbar_centerviews.dart';
import 'package:taxtisx/models/sidenavbar_items.dart';
import 'package:taxtisx/sidenavigator_setting/sidenavbar_footer.dart';
import 'package:taxtisx/sidenavigator_setting/sidenavbar_header.dart';
import 'package:taxtisx/sidenavigator_setting/sidenavbar_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TaxtisXApp());
}

class TaxtisXApp extends StatelessWidget {
  const TaxtisXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaxtisX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text('Taxtis X'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () async {},
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          SideNavigationBar(
            expandable: false,
            theme: sidenavbarTheme(),
            header: sidenavbarHeader(),
            footer: sidenavbarFooter(),
            selectedIndex: selectedIndex,
            items: sideItems,
            onTap: ((index) {
              setState(() {
                selectedIndex = index;
              });
            }),
          ),
          Expanded(child: views.elementAt(selectedIndex)),
        ],
      ),
    );
  }
}
