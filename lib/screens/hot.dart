import 'package:ecommerce_store/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/state.dart';
import '../widgets/product_builder.dart';

class HotScreen extends StatelessWidget {
  const HotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        List productList = cubit.productList;
        return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) => ProductBuilder(
                model: productList[index],
                onTap: () {
                  Navigator.pushNamed(context, '2',
                      arguments: productList[index]);
                },
              ),
            ),
        );

      },
    );
  }
}
