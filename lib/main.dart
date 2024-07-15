import 'package:flutter/material.dart';
import 'package:minimal_online_shop/data/repositories/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubits/all_cubits.dart';
import 'core/app.dart';

void main() {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) {
        return CartRepository();
      })
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return CartCubit(context.read<CartRepository>());
        }),
        BlocProvider(create: (context) {
          return ProductCubit();
        })
      ],
      child: const MainApp(),
    ),
  ));
}
