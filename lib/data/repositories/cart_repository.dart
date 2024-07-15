// import 'package:minimal_online_shop/data/models/product.dart';

// abstract class InterfaceProductRepository {
//   Future<void> getProducts();
//   Future<void> addProductToCart(Product product);
//   Future<void> deleteProduct(String id);
// }

// class CartRepository implements InterfaceProductRepository {
//   List<Product> products = [];

//   @override
//   Future<List<Product>> getProducts() async {
//     return products;
//   }

//   @override
//   Future<void> addProductToCart(Product product) async {
//     products.add(product);
//   }

//   @override
//   Future<void> deleteProduct(String id) async {
//     products.removeWhere((p) => p.id == id);
//   }
// }
