part of 'cartsproducts_cubit.dart';

@immutable
abstract class CartsproductsState extends Equatable {
  const CartsproductsState();

  @override
  List<Object> get props => [];
}

class CartsproductsInitial extends CartsproductsState {
  CartsproductsInitial();
}

class CartsproductLoading extends CartsproductsState {
  CartsproductLoading();
}

class CartsproductLoaded extends CartsproductsState {
  CartsproductLoaded({@required this.carts});
  final List<Cart> carts;

  @override
  List<Object> get props => [carts];

  // get c
}

class CartsProductsError extends CartsproductsState {
  final String message;
  CartsProductsError({this.message});

  @override
  String toString() => message;
}
