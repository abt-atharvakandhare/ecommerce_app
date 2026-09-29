import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../bloc/product_event.dart';
import 'cart_screen.dart';

class ProductCatalogScreen extends StatelessWidget{
  const ProductCatalogScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Discover Products',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
            ),
          actions: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 28),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<ProductBloc>(context),
                          child: const CartScreen(),
                        ),
                      ),
                    );
                  },
                ),
                BlockBuilder<ProductBloc, ProductState>(
                  builder: (context, state){
                    if(state is ProductLoadedState && state.cartItems.isNotEmpty){
                      return Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: deepPurple, shape: BoxShape.circle),
                          constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                          child: Text(
                            '${state.cartItems.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWidth: FontWeight.bold),
                            textAlign: 'center',
                          ),
                        ),
                      );
                    }
                    return constSizedBox.shrink();
                  },
                )
              ],
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state){
            if(state is ProductLoadingState){
              return const Center(child: CircularProgressiveIndicator(color: Colors.deepPurple));
            } else if(state is ProductLoadedState){
              final products = state.products;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SilverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.lenght,
                itemBuilder: (context, index){
                  final product = products[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0,6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF1F3F5),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                  child: Image.asset(
                                    product.image,
                                    fit:  Boxfit.contain,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image, size: 50, color:nColors.grey),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor:Colors.white.withOpacity(0.9),
                                  child: const Icon(Icons.favorite_border, size: 16, color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12,12,12,4),
                          child:Text(
                            product.title,
                            maxLines:2,
                            overflow: TetOverFlow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, height:1.2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12,0,12,12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize:16, color: Colors.deepPurple)
                              ),
                              InkWell(
                                onTap: (){
                                  BlocProvider.of<ProductBloc>(context).add(AddToCartEvent(product));
                                  ScaffoldMessenger.of(context).clearSnackBars();
                                  ScaffoldMessager.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.title} added to cart!'),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.deepPurple,
                                      duration: const Duration(milliseconds: 800),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
              else if(state is ProductErrorState){
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('Initializing...'));
            },
          };
        ),
    );
  }

}