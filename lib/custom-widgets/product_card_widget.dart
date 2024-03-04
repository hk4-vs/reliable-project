import 'package:flutter/material.dart';
import 'package:reliable/custom-widgets/image_widget.dart';
import 'package:reliable/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel? product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MyImageWidget(
                  url: product!.category!.image!,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              product!.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              product!.category!.name!,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.currency_rupee_rounded,
                  color: Colors.red,
                ),
                Text(
                  product!.price!.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final double radius;
  final String image;

  const ImageWidget({super.key, required this.radius, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.3))
      ]),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
