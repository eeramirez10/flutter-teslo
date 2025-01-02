import 'package:teslo_shop/config/constants/enviroment.dart';
import 'package:teslo_shop/features/auth/infrastructure/mappers/user_mapper.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';

class ProductMapper {
  static Product jsonToEntity(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        price: double.parse(json['price'].toString()) ,
        description: json['description'],
        slug: json['slug'],
        stock: json['stock'],
        sizes: List<String>.from( json['sizes'].map((x) => x)),
        gender: json['gender'],
        tags: List<String>.from(json['tags'].map((x) => x)),
        images: List<String>.from( 
          json['images'].map(
            (image) => image.startsWith('http')
              ? image
              : '${Enviroment.apiUrl}/files/product/$image'
          )
        ),
        user: UserMapper.userJsonToEntity(json['user'])
      );
  }
}
