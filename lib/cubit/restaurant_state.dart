part of 'restaurant_cubit.dart';

@immutable
abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {
  RestaurantInitial();
}

class RestaurantLoading extends RestaurantState {
  RestaurantLoading();
}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;
  RestaurantLoaded(this.restaurants);
}

class RestaurantError extends RestaurantState {
  final String message;
  RestaurantError(this.message);
}

class RestaurantAuthenticatedPicture extends RestaurantState {
  final File file;
  RestaurantAuthenticatedPicture(this.file);
}
