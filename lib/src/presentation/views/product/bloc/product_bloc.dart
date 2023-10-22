import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/domain/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState()) {
    on<GetProductDetails>((event, emit) {
      emit(ProductLoading());
      emit(ProductLoaded(p: event.p));
    });
    on<AddToFavorites>((event, emit) {
      event.p.favorite = !event.p.favorite;
      emit(ProductLoaded(p: event.p));
    },);
  }
}
