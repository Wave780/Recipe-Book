import 'package:flutter/material.dart';
import 'package:recipe_book_app/utils/route_generator.dart';
import 'package:recipe_book_app/utils/theme.dart';
import 'package:recipe_book_app/widgets/common/responsive_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Recipe Book App',
      theme: AppTheme.lightTheme,
      home: ResponsiveNavigation(),
    );
  }
}
