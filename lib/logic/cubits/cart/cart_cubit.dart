import 'package:bloc/bloc.dart';

import '../../../data/models/product.dart';
// import '../../../data/repositories/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(InitialCartState());

  // final InterfaceProductRepository interfaceProductRepository;

  List<Product> products = [];

  Future<void> getProducts() async {
    try {
      emit(LoadingCartState());
      await Future.delayed(const Duration(seconds: 2));
      emit(LoadedCartState(products));
    } catch (e) {
      print("Xatolik sodir bo'ladi");
      emit(ErrorCartState("Mahsulotlar olinmadi"));
    }
  }

  Future<void> addProductToCart(Product product) async {
    try {
      if (state is LoadedCartState) {
        products = (state as LoadedCartState).products;
      }

      emit(LoadingCartState());

      products.add(product);
      emit(LoadedCartState(products));
    } catch (e) {
      print("Qo'shishda xatolik");
      emit(ErrorCartState("Qo'shishda xatolik"));
    }
  }

  Future<void> deleteProductFromCart(String id) async {
    try {
      emit(LoadingCartState());
      products.removeWhere((p) => p.id == id);
      emit(LoadedCartState(products));
    } catch (e) {
      print("O'chirishda xatolik");
      emit(ErrorCartState("O'chirishda xatolik"));
    }
  }
}
