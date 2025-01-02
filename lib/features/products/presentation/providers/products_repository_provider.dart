

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/repositories/product_repository.dart';
import 'package:teslo_shop/features/products/infrastructure/datasources/products_datasource_impl.dart';
import 'package:teslo_shop/features/products/infrastructure/repositories/product_repository_impl.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref){

  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final dataSource = ProductsDatasourceImpl(accesToken:accessToken);

  final productsRepository = ProductsRepositoryImpl(datasource: dataSource);
  
  return productsRepository;
});