import 'package:arch/features/products/ui/pages/view_products/view_products_controller.dart';
import 'package:arch/features/products/ui/widgets/card_product.dart';
import 'package:flutter/material.dart';

class ViewProductsPage extends StatefulWidget {
  final ViewProductsController searchProductsController;
  const ViewProductsPage({super.key, required this.searchProductsController});

  @override
  State<ViewProductsPage> createState() => _ViewProductsPageState();
}

class _ViewProductsPageState extends State<ViewProductsPage> {
  late ViewProductsController searchProductsController;

  @override
  void initState() {
    super.initState();

    searchProductsController = widget.searchProductsController;
    searchProductsController.addListener(() {
      setState(() {});
    });

    searchProductsController.findProducts();
  }

  @override
  void dispose() {
    searchProductsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Products')),
      body:
          searchProductsController.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: searchProductsController.products.length,
                itemBuilder: (context, index) {
                  final product = searchProductsController.products[index];
                  return CardProduct(name: product.name);
                },
              ),
    );
  }
}
