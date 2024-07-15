//! InitialState - boshlang'ich holati
//! LoadingState - yuklanish holati
//! LoadedState - yuklab bo'lgan holati
//! ErrorState - xatolik holati

import 'package:minimal_online_shop/data/models/product.dart';

class ProductState {}

final class InitialState extends ProductState {}

final class LoadingState extends ProductState {}

final class LoadedState extends ProductState {
  List<Product> products = [];

  LoadedState(this.products);
}

final class ErrorState extends ProductState {
  String message;

  ErrorState(this.message);
}
