import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minimal_online_shop/logic/cubits/cart/cart_cubit.dart';
import 'package:minimal_online_shop/logic/cubits/product/product_cubit.dart';
import 'package:minimal_online_shop/logic/cubits/product/product_stete.dart';
import 'package:minimal_online_shop/logic/cubits/theme_mode/theme_mode_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _titleTextController = TextEditingController();
  final _imageUrlTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<ProductCubit>().getProducts();
    });
  }

  bool haveAction = false;

  @override
  void dispose() {
    super.dispose();
    _titleTextController.dispose();
    _imageUrlTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Market"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () {
                context.read<ThemeModeCubit>().toggleTheme();
              },
              icon: const Icon(Icons.light_mode))
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          print(state);
          if (state is InitialProductState) {
            return const Center(
              child: Text("Ma'lumot hali yuklanmadi"),
            );
          }

          if (state is LoadingProductState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorProductState) {
            return Center(
              child: Text(state.message),
            );
          }

          final products = (state as LoadedProductState).products;

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    haveAction = !haveAction;
                  });

                  Future.delayed(const Duration(seconds: 3), () {
                    setState(() {
                      haveAction = false;
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        product.imageUrl,
                      ),
                      fit: BoxFit.cover,
                      opacity: haveAction ? 0.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        bottom: haveAction ? 35 : -40,
                        left: haveAction ? 35 : -40,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<ProductCubit>()
                                  .makeFavourite(product.id);
                            },
                            icon: Icon(
                              Icons.favorite_rounded,
                              color: product.isFavourite
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        bottom: haveAction ? 35 : -40,
                        right: haveAction ? 35 : -40,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<CartCubit>()
                                  .addProductToCart(product);

                              Fluttertoast.showToast(
                                  msg: "Added to cart!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      if (product.isFavourite)
                        const Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      AnimatedPositioned(
                        top: haveAction ? 35 : -40,
                        left: haveAction ? 35 : -40,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              _titleTextController.text = product.title;
                              _imageUrlTextController.text = product.imageUrl;

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Form(
                                    key: _formKey,
                                    child: AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: _titleTextController,
                                            decoration: const InputDecoration(
                                                hintText: "Mahsulot nomi"),
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return "Rasm uchun nom kiriting";
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFormField(
                                            controller: _imageUrlTextController,
                                            decoration: const InputDecoration(
                                                hintText: "Rasm URL manzili"),
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return "Rasm uchun URL manzilni kiriting";
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Bekor qilish"),
                                        ),
                                        FilledButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<ProductCubit>()
                                                    .editProduct(
                                                        product.id,
                                                        _titleTextController
                                                            .text,
                                                        _imageUrlTextController
                                                            .text);

                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text("Yangilash"))
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        top: haveAction ? 35 : -40,
                        right: haveAction ? 35 : -40,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<ProductCubit>()
                                  .deleteProduct(product.id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: () {
          _titleTextController.clear();
          _imageUrlTextController.clear();
          showDialog(
            context: context,
            builder: (context) {
              return Form(
                key: _formKey,
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _titleTextController,
                        decoration:
                            const InputDecoration(hintText: "Mahsulot nomi"),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Rasm uchun nom kiriting";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _imageUrlTextController,
                        decoration:
                            const InputDecoration(hintText: "Rasm URL manzili"),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Rasm uchun URL manzilni kiriting";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Bekor qilish"),
                    ),
                    FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ProductCubit>().addProduct(
                                UniqueKey().toString(),
                                _titleTextController.text,
                                _imageUrlTextController.text,
                                false);

                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Saqlash"))
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
