import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerWidget {
  final String productId;
  const ProductScreen({required this.productId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar producto'),
      ),
      body: Center(
        child: Text(productId),
      ),
    );
  }
}
