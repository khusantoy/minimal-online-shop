// InitialState - boshlang'ich holat
// LoadingState - yuklanish holati
// LoadedState - yuklanib bo'lgan holati
// ErrorState - xatolik holati

part of 'cart_cubit.dart';

sealed class CartState {}

final class InitialState extends CartState {}

final class LoadingState extends CartState {}

final class LoadedState extends CartState {
  List<Product> products = [];

  LoadedState(this.products);
}

final class ErrorState extends CartState {
  String message;

  ErrorState(this.message);
}
