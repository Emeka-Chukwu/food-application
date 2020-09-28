part of 'users_cubit.dart';

@immutable
abstract class UsersState {
  UsersState();
  List<Object> get props => [];
}

class UsersInitial extends UsersState {
  UsersInitial();
}

class UserAuthenticating extends UsersState {
  UserAuthenticating();
}

class NormalUserAuthenticated extends UsersState {
  final Users user;
  NormalUserAuthenticated(this.user);
  // var qty = user.car

  @override
  List<Object> get props => [
        user.name,
        user.email,
        user.imageUrl,
        user.id,
        user.stripeId,
        user.cart.length,
        user.cart
      ];
}

class RestaurantUserAuthenticated extends UsersState {
  final Restaurant restaurant;
  RestaurantUserAuthenticated(this.restaurant);
  @override
  List<Object> get props => [
        restaurant.name,
        restaurant.email,
        restaurant.imageUrl,
        restaurant.id,
        restaurant.rating,
        restaurant.popular
      ];
}

class UserAuthenticatedError extends UsersState {
  final String message;
  UserAuthenticatedError(this.message);
}

class UserAuthenticatedPicture extends UsersState {
  final File file;
  UserAuthenticatedPicture(this.file);
}
