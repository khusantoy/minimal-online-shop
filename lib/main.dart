import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        })
      ],
      child: const MainApp(),
    ),
  );
}
