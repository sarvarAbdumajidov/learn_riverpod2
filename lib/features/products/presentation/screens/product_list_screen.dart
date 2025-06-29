import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/features/products/application/cart_provider.dart';
import 'package:learn_riverpod2/features/products/application/product_provider.dart';
import 'package:learn_riverpod2/features/products/presentation/screens/cart_screen.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shoply',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,

        actions: [
          Consumer(
            builder: (context, ref, _) {
              final count = ref.watch(cartProvider).length;
              return IconButton(
                icon: Stack(
                  children: [
                    Icon(Icons.shopping_cart,color: Colors.white,),
                    if (count > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.red,
                          child: Text(
                            '$count',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                },
              );
            },
          ),
        ],
      ),
      body: productState.when(
        data:
            (products) => ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(

                  selected: true,

                  title: Text(product.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(product);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('${product.name} add to cart')));
                    },
                    icon: Icon(Icons.add_shopping_cart),color: Colors.lightBlue,
                  ),
                );
              },
            ),
        loading: () => Center(child: LinearProgressIndicator()),
        error: (e, _) => Center(child: Text('Error $e')),
      ),
    );
  }
}
