// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState {}

class CategoriesLoading extends HomeState {}

class CategoriesLoaded extends HomeState {
  List<Category> categories;

  CategoriesLoaded({
    required this.categories,
  });
}

class ProductsLoading extends HomeState {
  List<Category> categories;
  int current;
  ProductsLoading({
    required this.categories,
    required this.current,
  });
}

class ProductsLoaded extends HomeState {
  List<Category> categories;
  List<Product> products;
  int current;
  ProductsLoaded({
    required this.categories,
    required this.products,
    required this.current,
  });
}
