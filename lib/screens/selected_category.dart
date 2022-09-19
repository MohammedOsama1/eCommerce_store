import 'package:ecommerce_store/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/state.dart';
import '../widgets/product_builder.dart';

class SelectedCategory extends StatelessWidget {
  const SelectedCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String categoryName = ModalRoute.of(context)!.settings.arguments as String ;

    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {

        },
        builder: (context, state) {

          HomeCubit cubit = HomeCubit.get(context);

          cubit.getCategory(categoryName);
          List data = cubit.productCategoryList;
          print(data.length);

          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  cubit.clearData();
                  data.clear();

                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) => ProductBuilder(
                  model: data[index],
                  onTap: () {
                    Navigator.pushNamed(context, '2', arguments: data[index]);
                  },
                ),
              ),
            ),
          );
        });
  }
}
