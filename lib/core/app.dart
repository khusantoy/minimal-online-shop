import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_online_shop/logic/cubits/theme_mode/theme_mode_cubit.dart';
import 'package:minimal_online_shop/ui/screens/main_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, bool>(
      builder: (context, state) {
        return  MaterialApp(
          theme: state? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        );
      },
    );
  }
}
