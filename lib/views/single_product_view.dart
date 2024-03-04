import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reliable/custom-widgets/image_widget.dart';
import 'package:reliable/models/product_model.dart';

class SingleProductView extends StatefulWidget {
  const SingleProductView({super.key, required this.product});
  final ProductModel product;

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  CarouselController carouselController = CarouselController();
  int imageIndex = 0;
  double iconSize = 24.0;
  int quantity = 1;
  bool isLightTheme = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Product"),
        actions: const [
          Icon(Icons.more_vert_rounded),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                height: 200.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    imageIndex = index;
                  });
                },
              ),
              items: widget.product.images!.map((i) {
                return MyImageWidget(url: widget.product.category!.image!);
              }).toList(),
            ),
            const SizedBox(
              height: 6,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int index = 0;
                      index < widget.product.images!.length;
                      index++) ...[
                    Container(
                      height: (imageIndex == index) ? 8 : 6,
                      width: (imageIndex == index) ? 8 : 6,
                      margin: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (imageIndex == index)
                              ? Theme.of(context).primaryColor
                              : Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.3)),
                    )
                  ]
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      widget.product.title!,
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.currency_rupee_rounded,
                      color: Colors.red,
                    ),
                    Text(
                      widget.product.price!.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.product.category!.name!.toString(),
              // style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: iconSize,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: iconSize,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: iconSize,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: iconSize,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: iconSize,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "5.0",
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    if (quantity > 1) {
                      quantity = quantity - 1;
                    }
                  }),
                  child: Icon(
                    CupertinoIcons.minus_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                    width: 20, child: Center(child: Text(quantity.toString()))),
                GestureDetector(
                  onTap: () => setState(() {
                    quantity = quantity + 1;
                  }),
                  child: Icon(
                    CupertinoIcons.add_circled,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.product.description!.toString(),
              // style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 46,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
            child: Text(
          "Add to cart",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        )),
      ),
    );
  }
}
