import 'package:arch/features/products/ui/pages/view_products/view_products_store.dart';
import 'package:arch/features/products/ui/widgets/card_product.dart';
import 'package:flutter/material.dart';

class ViewProductsPage extends StatefulWidget {
  final ViewProductsStore searchProductsStore;
  const ViewProductsPage({super.key, required this.searchProductsStore});

  @override
  State<ViewProductsPage> createState() => _ViewProductsPageState();
}

class _ViewProductsPageState extends State<ViewProductsPage> {
  late ViewProductsStore searchProductsStore;

  @override
  void initState() {
    super.initState();

    searchProductsStore = widget.searchProductsStore;
    searchProductsStore.addListener(() {
      setState(() {});
    });

    searchProductsStore.findProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Products')),
      body:
          searchProductsStore.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: searchProductsStore.products.length,
                itemBuilder: (context, index) {
                  final product = searchProductsStore.products[index];
                  return CardProduct(name: product.name);
                },
              ),
    );
  }
}
