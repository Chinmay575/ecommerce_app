// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  Product p;
  ProductLoaded({
    required this.p,
  });
}
