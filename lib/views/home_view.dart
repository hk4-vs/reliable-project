import 'package:flutter/material.dart';
import 'package:reliable/custom-widgets/product_card_widget.dart';
import 'package:reliable/models/product_model.dart';
import 'package:reliable/api-services/api_services.dart';
import 'package:reliable/utils/utils.dart';

import 'single_product_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ProductModel> products = [];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await fetchProductData();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reliable Services'),
        ),
        body: FutureBuilder(
            future: ApiService().getAllProductsData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(snapshot.error.toString()),
                    TextButton(
                        onPressed: () {
                          fetchProductData();
                        },
                        child: const Text("Refresh"))
                  ],
                ));
              } else {
                products = snapshot.data as List<ProductModel>;
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.7,
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemCount: products.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingleProductView(
                                      product: products[index],
                                    )),
                          );
                        },
                        child: ProductCardWidget(
                          product: products[index],
                        ),
                      );
                    });
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ApiService.pickImageFromGallery(context: context)
                .then((imageUploadResponse) {
              if (imageUploadResponse != null) {
                Utils.showImageUploaded(
                    context: context, uploadImage: imageUploadResponse);
              }
            });
          },
          child: const Icon(Icons.add_a_photo_outlined),
        ),
      ),
    );
  }

  Future<void> fetchProductData() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _products = await ApiService().getAllProductsData();
    setState(() {
      products = _products;
    });
  }
}
