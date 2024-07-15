import 'package:bloc/bloc.dart';
import 'package:minimal_online_shop/logic/cubits/product/product_stete.dart';
import 'package:minimal_online_shop/data/models/product.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(InitialProductState());

  List<Product> products = [];

  Future<void> getProducts() async {
    try {
      emit(LoadingProductState());
      await Future.delayed(const Duration(seconds: 2));

      List<Product> products = [
        Product(
            id: "product1",
            title: "Tesla",
            imageUrl:
                "https://www.thedetroitbureau.com/wp-content/uploads/2020/10/2020-Tesla-Model-S-driving.jpg",
            isFavourite: false)
      ];

      // throw("Xatolik");
      emit(LoadedProductState(products));
    } catch (e) {
      print("Xatolik sodir bo'ldi");
      emit(ErrorProductState("Mahsulotlar olinmadi"));
    }
  }

  Future<void> addProduct(
      String id, String title, String imageUrl, bool isFavourite) async {
    try {
      if (state is LoadedProductState) {
        products = (state as LoadedProductState).products;
      }

      emit(LoadingProductState());
      await Future.delayed(const Duration(seconds: 2));
      // await Future.delayed(const Duration(seconds: 2))

      products.add(Product(
          id: id, title: title, imageUrl: imageUrl, isFavourite: isFavourite));

      emit(LoadedProductState(products));
    } catch (e) {
      print("Qo'shishda xatolik");
      emit(ErrorProductState("Qo'shishda xatolik"));
    }
  }

  Future<void> editProduct(String id, String title, String imageUrl) async {
    try {
      if (state is LoadedProductState) {
        products = (state as LoadedProductState).products;
      }

      emit(LoadingProductState());
      await Future.delayed(const Duration(seconds: 2));
      // await Future.delayed(const Duration(seconds: 2))

      for (var product in products) {
        if (product.id == id) {
          product.title = title;
          product.imageUrl = imageUrl;
        }
      }

      emit(LoadedProductState(products));
    } catch (e) {
      print("O'zgartirishda xatolik");
      emit(ErrorProductState("O'zgartirishda xatolik xatolik"));
    }
  }

  Future<void> makeFavourite(String id) async {
    try {
      if (state is LoadedProductState) {
        products = (state as LoadedProductState).products;
      }

      emit(LoadingProductState());
      await Future.delayed(const Duration(seconds: 2));
      // await Future.delayed(const Duration(seconds: 2))

      for (var product in products) {
        if (product.id == id) {
          product.isFavourite = !product.isFavourite;
        }
      }

      emit(LoadedProductState(products));
    } catch (e) {
      print("O'zgartirishda xatolik");
      emit(ErrorProductState("O'zgartirishda xatolik xatolik"));
    }
  }

  Future<void> deleteProduct(
    String id,
  ) async {
    try {
      if (state is LoadedProductState) {
        products = (state as LoadedProductState).products;
      }

      emit(LoadingProductState());
      await Future.delayed(const Duration(seconds: 2));
      // await Future.delayed(const Duration(seconds: 2))

      // id qiymati 1 ga teng bo'lgan mahsulotni o'chirib tashlash
      products.removeWhere((product) => product.id == id);

      emit(LoadedProductState(products));
    } catch (e) {
      print("O'chirishda xatolik xatolik");
      emit(ErrorProductState("O'chirishda xatolik"));
    }
  }
}
