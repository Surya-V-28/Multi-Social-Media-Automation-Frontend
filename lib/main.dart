import 'package:flutter/material.dart';

import 'app.dart';
import 'injectable/configuration.dart';

import 'package:business_logic/business_logic.dart' as business_logic;

void main() {
  business_logic.registerDependencies();
  configureDependencies();

  runApp(const App());
}
