import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{
  final ProductRepository repository;
  final List<Product> _cart =[];

  ProductBloc({required this.repository}) : super(ProductInitialState()){
    on<FetchProductsEvent>(_onFetchProducts);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  Future<void> _onFetchProducts(
      FetchProductEvent event, Emitter<ProductState> emit) async{
    emit(ProductLoadingState());
    try{
      final products = await repository.getProducts();
      emit(ProductLoadedState(products: products, cartItems: List.from(_cart)));
    } catch (e){
      emit(ProductErrorState(e.toString()));
  }
  }

  void _onAddToCart(AddToCartEvent event, Emitter<ProductState> emit){
    _cart.add(event.product);
    if(state is ProductLoadedState){
      final currentState = State as ProductLoadedState;
      emit(ProductLoadedState(
        products: currentState.products, cartItems: List.from(_cart)));
    }
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<ProductState> emit){
    _cart.remove(event.product);
    if(state is ProductLoadedState){
      final currentState = State as ProductLoadedState;
      emit(ProductLoadedState(
          products: currentState.products, cartItems: List.from(_cart)));
    }
  }
}