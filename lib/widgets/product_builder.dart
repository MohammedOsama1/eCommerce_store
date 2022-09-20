import 'package:ecommerce_store/cubit/cubit.dart';
import 'package:flutter/material.dart';

import 'product_model.dart';

class ProductBuilder extends StatelessWidget {
  const ProductBuilder({Key? key, required this.model, required this.onTap, this.color})
      : super(key: key);
  final ProductModel model;

  final Function() onTap;
  final Color? color ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 220,
        width: MediaQuery.of(context).size.width / 2,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  model.image,
                  height: 100,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      model.title,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(r'$'),
                    Text(' ${model.price.toString()}',
                        style: const TextStyle(fontSize: 18)),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                         HomeCubit.get(context). addTOFav(model);

                        },
                        child: CircleAvatar(
                          backgroundColor: color,
                            child: Icon(Icons.favorite_border)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
