
import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/enviroment.dart';
import 'package:teslo_shop/features/products/domain/datasources/products_datasource.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';
import 'package:teslo_shop/features/products/infrastructure/mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {

  late final Dio dio;
  final String accesToken;

  ProductsDatasourceImpl({required this.accesToken}) : dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accesToken'
      }
    )
  );

  
  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 10}) async {
    final response = await dio.get('/products?limit=$limit&offset=$offset');
    
    final List<Product> products = [];
    for (final product in response.data ?? []){
      products.add(ProductMapper.jsonToEntity(product));
    }


    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
  
}