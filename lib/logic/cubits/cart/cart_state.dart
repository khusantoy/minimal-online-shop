// InitialState - boshlang'ich holat
// LoadingState - yuklanish holati
// LoadedState - yuklanib bo'lgan holati
// ErrorState - xatolik holati

part of 'cart_cubit.dart';

sealed class CartState {}

final class InitialCartState extends CartState {}

final class LoadingCartState extends CartState {}

final class LoadedCartState extends CartState {
  List<Product> products = [];

  LoadedCartState(this.products);
}

final class ErrorCartState extends CartState {
  String message;

  ErrorCartState(this.message);
}
