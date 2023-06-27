import 'package:flutter/material.dart';
import 'package:instagram_flutter/Views/UI/screens/add_post_screens.dart';
import 'package:instagram_flutter/Views/UI/screens/feed_screen.dart';

final homeScreenItems = [
  const FeedScreen(),
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
