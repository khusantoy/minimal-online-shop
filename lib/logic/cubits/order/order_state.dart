// InitialState - boshlang'ich holat
// LoadingState - yuklanish holati
// LoadedState - yuklanib bo'lgan holati
// ErrorState - xatolik holati

part of 'order_cubit.dart';


sealed class OrderState {}

final class InitialOrderState extends OrderState {}

final class LoadingOrderState extends OrderState {}

final class LoadedOrderState extends OrderState {
  List<Product> products = [];

  LoadedOrderState(this.products);
}

final class ErrorOrderState extends OrderState {
  String message;

  ErrorOrderState(this.message);
}
