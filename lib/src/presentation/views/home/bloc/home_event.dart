// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent {}

class IntialFetchEvent extends HomeEvent {}

class GetProducts extends HomeEvent {
  List<Category> categories;
  int category;
  GetProducts({
    required this.categories,
    required this.category,
  });
}
