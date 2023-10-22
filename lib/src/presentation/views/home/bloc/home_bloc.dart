import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/data/remote/api.dart';
import 'package:ecommerce_app/src/domain/models/category.dart';
import 'package:ecommerce_app/src/domain/models/product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<IntialFetchEvent>((event, emit) async {
      emit(CategoriesLoading());
      List<Category> categories = await API.getCategories();
      emit(CategoriesLoaded(categories: categories));
    });
    on<GetProducts>(
      (event, emit) async {
        emit(ProductsLoading(
          categories: event.categories,
          current: event.category,
        ));
        List<Product> products = [];
        if (event.category == 0) {
          products = await API.getAllProducts();
        } else {
          products = await API.getProductsByCategory(event.category);
        }
        emit(ProductsLoaded(
          categories: event.categories,
          products: products,
          current: event.category,
        ));
      },
    );
  }
}
