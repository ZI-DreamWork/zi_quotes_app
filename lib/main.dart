import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zi_quotes_app/presentation/cubit/theme_color_cubit.dart';
import 'package:zi_quotes_app/presentation/screens/home_screen.dart';
import 'package:zi_quotes_app/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeColorCubit(),
      child: BlocBuilder<ThemeColorCubit, Color>(
        builder: (context, themeColor) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.from(
                colorScheme: ColorScheme.fromSeed(seedColor: themeColor)),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
