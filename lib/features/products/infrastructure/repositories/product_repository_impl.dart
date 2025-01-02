
import 'package:teslo_shop/features/products/domain/datasources/products_datasource.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';
import 'package:teslo_shop/features/products/domain/repositories/product_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {

  final ProductsDatasource datasource;

  ProductsRepositoryImpl({required this.datasource});

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
      return datasource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
    return datasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 10}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    return datasource.searchProductByTerm(term);
  }
  
}