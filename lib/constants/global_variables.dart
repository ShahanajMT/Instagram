import 'package:flutter/material.dart';
import 'package:instagram_flutter/Views/UI/screens/add_post_screens.dart';

final homeScreenItems = [
  Container(
    color: Colors.green,
    alignment: Alignment.center,
    child: const Text('Page 1'),
  ),
  Container(
    color: Colors.blue,
    alignment: Alignment.center,
    child: const Text('Page 2'),
  ),
  const AddPostScreen(),
  Container(
    color: Colors.cyan,
    alignment: Alignment.center,
    child: const Text('Page 4'),
  ),
  Container(
    color: Colors.purple,
    alignment: Alignment.center,
    child: const Text('Page 5'),
  ),
];
