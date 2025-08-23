import 'package:flutter/material.dart';

abstract class PageDependency {
  void init();
  StatefulWidget getPage();
}
