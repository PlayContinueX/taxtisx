import 'package:side_navigation/side_navigation.dart';

SideNavigationBarTheme sidenavbarTheme() {
  return SideNavigationBarTheme(
    dividerTheme: SideNavigationBarDividerTheme.standard(),
    itemTheme: SideNavigationBarItemTheme.standard(),
    togglerTheme: SideNavigationBarTogglerTheme.standard(),
  );
}
