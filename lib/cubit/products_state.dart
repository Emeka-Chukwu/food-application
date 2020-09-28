part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {
  ProductsInitial();
}

class ProductLoading extends ProductsState {
  ProductLoading();
}

class ProductLoaded extends ProductsState {
  final List<Product> products;
  ProductLoaded({@required this.products});

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductsState {
  final String message;
  ProductError({@required this.message});
  // String toString() => 'TodosNotLoaded';

  String toString() => message;
}

class GetProductImageFrom extends ProductsState {
  final File productImage;
  GetProductImageFrom(this.productImage);
}

class ProductCartLoaded extends ProductsState {
  final List<Cart> productsCart;
  ProductCartLoaded({@required this.productsCart});

  @override
  List<Object> get props => [productsCart];
}

class ProductCartInitial extends ProductsState {
  ProductCartInitial();
}
