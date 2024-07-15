import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/all_cubits.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<CartCubit>().getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: Text("Ma'lumot hali yuklanmadi"),
            );
          }

          if (state is LoadingState) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          final products = (state as LoadedState).products;

          return products.isEmpty
              ? const Center(
                  child: Text("No available products"),
                )
              : GridView.builder(
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

                    return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            product.imageUrl,
                          ),
                          fit: BoxFit.cover,
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
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
