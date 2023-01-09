import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

SideNavigationBarHeader sidenavbarHeader() {
  return SideNavigationBarHeader(
    image: const Icon(Icons.abc),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Text('Taxtis X'),
        Padding(padding: EdgeInsets.only(right: 10))
      ],
    ),
    subtitle: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Text(
          'ver 1.0.0',
          style: TextStyle(fontSize: 7),
        ),
        Padding(padding: EdgeInsets.only(right: 10))
      ],
    ),
  );
}
