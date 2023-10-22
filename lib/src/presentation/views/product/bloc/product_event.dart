// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductEvent {}

class GetProductDetails extends ProductEvent {
  Product p;
  GetProductDetails({
    required this.p,
  });
}

class AddToFavorites extends ProductEvent {
  Product p;
  AddToFavorites({
    required this.p,
  });
}
