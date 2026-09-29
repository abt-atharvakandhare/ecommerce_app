import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class CartScreen extends StatelessWidget{
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<ProductBloc, ProductState<(
        builder: (context, state){
          if (state is ProductLoadedState){
            final cart = state.CartItems;
            if(cart.isEmpty){
              return const Center(child: Text('Nothing to show in Cart!!'));
            }
            return ListView.buider(
              itemCount: cart.length,
              itemBuilder: (Context, index){
                return ListTitle(
                  leading: Image.network(item.image, width: 40, height: 40),
                  title: Text(item.title),
                  subtitle:Text('\$${item.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart, color: Colors.red),
                    onPressed: (){
                      BlocProvider.of<ProductBloc>(context)
                          .add(RemoveFromCartEvent(item));
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgreeIndicator());
        },
      ),
    );
  }
}