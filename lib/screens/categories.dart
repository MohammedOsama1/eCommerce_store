import 'dart:ui';

import 'package:ecommerce_store/widgets/theme.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List category = [
      "electronics",
      "jewelery",
      "men's clothing",
      "women's clothing"
    ];
    List images = [
      "https://www.ge.com/research/sites/default/files/styles/hero_banner/public/images/capabilities/2020-08/pcb3.jpg?itok=_WvwlMts",
      "https://assets.ynap-content.com/story-head-content-1stFebruary2021-1611749733226.jpeg",
      "https://onlineshop.oxfam.org.uk/file/v3485178388144358963/general/mens-coats-573x573.jpg",
      "https://static.standard.co.uk/s3fs-public/thumbnails/image/2019/02/20/12/lfwstreetstyle2002j.jpg?width=1200&auto=webp&quality=75"
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 1.7,
          mainAxisSpacing: 10,
        ),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, '3',arguments: category[index]);
            },
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    )),
                Positioned(
                  top: 84,
                  child: Container(
                      color: Colors.black,
                      child: Text(
                        ' ${category[index]} ',
                        style: primaryStyle.copyWith(
                            color: Colors.white, fontSize: 17),
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
