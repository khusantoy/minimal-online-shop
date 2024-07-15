import 'package:bloc/bloc.dart';

import '../../../data/models/product.dart';
// import '../../../data/repositories/Order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(InitialOrderState());

  // final InterfaceProductRepository interfaceProductRepository;

  List<Product> products = [];

  Future<void> getProducts() async {
    try {
      emit(LoadingOrderState());
      await Future.delayed(const Duration(seconds: 2));
      emit(LoadedOrderState(products));
    } catch (e) {
      print("Xatolik sodir bo'ladi");
      emit(ErrorOrderState("Mahsulotlar olinmadi"));
    }
  }

  Future<void> addProductToOrder(List<Product> newProducts) async {
    
    print(newProducts);
    try {
      if (state is LoadedOrderState) {
        products = (state as LoadedOrderState).products;
      }

      emit(LoadingOrderState());

      for (var element in newProducts) {
        products.add(element);
      }
      emit(LoadedOrderState(products));
    } catch (e) {
      print("Qo'shishda xatolik");
      emit(ErrorOrderState("Qo'shishda xatolik"));
    }
  }
}
