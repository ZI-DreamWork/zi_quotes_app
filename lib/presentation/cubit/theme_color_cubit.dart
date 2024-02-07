import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeColorCubit extends Cubit<Color> {
  ThemeColorCubit() : super(Colors.green);
  void changeThemeColor(Color color) {
    print('Selected Color: $color');
    emit(color); // Change the theme color
  }
}
