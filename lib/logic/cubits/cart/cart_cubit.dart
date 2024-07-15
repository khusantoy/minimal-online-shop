import 'package:bloc/bloc.dart';

import '../../../data/models/product.dart';
import '../../../data/repositories/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.interfaceProductRepository) : super(InitialState());

  final InterfaceProductRepository interfaceProductRepository;

  List<Product> products = [];

  Future<void> getProducts() async {
    try {
      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 2));
      emit(LoadedState(products));
    } catch (e) {
      print("Xatolik sodir bo'ladi");
      emit(ErrorState("Mahsulotlar olinmadi"));
    }
  }

  Future<void> addProductToCart(Product product) async {
    try {
      if (state is LoadedState) {
        products = (state as LoadedState).products;
      }

      emit(LoadingState());

      products.add(product);
      emit(LoadedState(products));
    } catch (e) {
      print("Qo'shishda xatolik");
      emit(ErrorState("Qo'shishda xatolik"));
    }
  }

  Future<void> deleteProductFromCart(String id) async {
    try {
      emit(LoadingState());
      products.removeWhere((p) => p.id == id);
      emit(LoadedState(products));
    } catch (e) {
      print("O'chirishda xatolik");
      emit(ErrorState("O'chirishda xatolik"));
    }
  }
}
