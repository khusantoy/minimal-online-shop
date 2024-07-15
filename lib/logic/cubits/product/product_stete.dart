//! InitialState - boshlang'ich holati
//! LoadingState - yuklanish holati
//! LoadedState - yuklab bo'lgan holati
//! ErrorState - xatolik holati

import 'package:minimal_online_shop/data/models/product.dart';

class ProductState {}

final class InitialProductState extends ProductState {}

final class LoadingProductState extends ProductState {}

final class LoadedProductState extends ProductState {
  List<Product> products = [];

  LoadedProductState(this.products);
}

final class ErrorProductState extends ProductState {
  String message;

  ErrorProductState(this.message);
}
