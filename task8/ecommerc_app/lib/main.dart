import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './features/product/presentation/pages/start.dart';
import './injction_contaner.dart' as di;
import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await di.init();
  runApp(const MyApp());
}