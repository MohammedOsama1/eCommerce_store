import 'package:ecommerce_store/widgets/product_model.dart';
import 'package:ecommerce_store/widgets/theme.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel model = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.grey.withOpacity(.6),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        child: Image.network(
                          model.image,
                          height: 110,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            model.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: primaryStyle.copyWith(),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 270,
                  child: Row(
                    children: [
                      Text(
                        ' Rate  ',
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: primaryStyle.copyWith(fontSize: 18),
                      ),
                      Text(
                        model.rating!.rate.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: primaryStyle.copyWith(fontSize: 18),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.red,
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  model.description,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: primaryStyle.copyWith(fontSize: 18),
                )),
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
