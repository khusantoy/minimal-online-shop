import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_online_shop/logic/cubits/theme_mode/theme_mode_cubit.dart';

import 'logic/cubits/all_cubits.dart';
import 'core/app.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return CartCubit();
        }),
        BlocProvider(create: (context) {
          return ProductCubit();
        }),
        BlocProvider(create: (context) {
          return OrderCubit();
        }),
        BlocProvider(create: (context) {
          return ThemeModeCubit();
        })
      ],
      child: const MainApp(),
    ),
  );
}
