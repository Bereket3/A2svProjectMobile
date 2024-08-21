import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injction_contaner.dart';
import '../bloc/product_bloc.dart';
import 'add_product.dart';
import 'home.dart';
import 'update.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => sl<ProductBloc>(),
      child:  MaterialApp(
        title: 'Flutter interface',
        initialRoute: '/',
        routes: {
          '/': (context) =>  const Home(),
          '/add': (context) => const AddProduct(),
          '/update': (context) => const UpdatePage(), 

        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}