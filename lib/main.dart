import 'package:ecommerce_store/cubit/cubit.dart';
import 'package:ecommerce_store/screens/selected_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout.dart';
import 'screens/product_details_screen.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '1',
        routes: {
          '1' : (context)=> const LayoutScreen(),
          '2' :(context) => const ProductDetailsScreen(),
          '3' :(context) => const SelectedCategory()

        },
      ),
    );
  }
}


