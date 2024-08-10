import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/detail.dart';
import 'pages/add_product.dart';
import 'pages/search.dart';
import 'pages/update_product.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const Home(),
    '/detail': (context) => const Detail(), 
    '/add': (context) => const AddProduct(),
    '/search': (context) => const Search(),
    '/update': (context) => const UpdateProduct(),
  },
  theme: ThemeData(fontFamily: 'Poppins'),
));
