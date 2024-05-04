import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_pagination/src/repository/product_repository.dart';
import 'package:list_pagination/src/state/product_list_state.dart';

final productControllerProvider = StateNotifierProvider<ProductListController, ProductListState>((ref){
  final repository = ref.watch(productRepositoryProvider);
  return ProductListController(repository: repository);
});

class ProductListController extends StateNotifier<ProductListState>{
  final ProductRepository _repository;

  ProductListController({
    required ProductRepository repository,
  }): _repository = repository, super(ProductListState.initial()){
    loadProducts();
  }

  void loadProducts () async {
    if(state.maxLoaded){
      return;
    }
    if(state.loading){
      return;
    }
    state = state.copyWith(loading: true);
    final products = await _repository.getProducts(skip: state.products.length);
    if(products!=null){
      if(products.isEmpty){
        state = state.copyWith(maxLoaded: true, loading: false);
      }
      state = state.copyWith(products: [...state.products, ...products], loading: false);
    } else {
      state = state.copyWith(loading: false);
    }
  }
}