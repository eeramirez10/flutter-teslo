import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';
import 'package:teslo_shop/features/products/domain/repositories/product_repository.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_repository_provider.dart';


final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref){

  final productsRepository= ref.watch(productsRepositoryProvider);

    return ProductsNotifier(productsRepository: productsRepository);
});

class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository productsRepository;

  ProductsNotifier({required this.productsRepository})
      : super(ProductsState()) {
    loadNextPage();
  }

  Future loadNextPage() async {

    if(state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    print(state.offset);


    final products = await productsRepository.getProductsByPage(
        limit: state.limit, offset: state.offset);

    if(products.isEmpty){
      state = state.copyWith(isLastPage: true, isLoading: false);

      return;
    }

    state = state.copyWith(
      products: [ ...state.products,  ...products], 
      isLoading: false, 
      isLastPage: false, 
      offset: state.offset
    );
  }
}

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.products = const []});

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
          isLastPage: isLastPage ?? this.isLastPage,
          limit: limit ?? this.limit,
          offset: offset ?? this.offset,
          isLoading: isLoading ?? this.isLoading,
          products: products ?? this.products);
}
