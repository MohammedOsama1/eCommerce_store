import 'package:ecommerce_store/cubit/cubit.dart';
import 'package:ecommerce_store/helpers/shared_pref.dart';
import 'package:ecommerce_store/screens/selected_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout.dart';
import 'screens/on_boarding/onBoarding.dart';
import 'screens/product_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  bool? oldUser ;
  if(CashHelper.getData('oldUser?') == null )
    {
      oldUser = false;
    } else {
    oldUser = CashHelper.getData('oldUser?');
  }
  runApp(MyApp(oldUser: oldUser!));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.oldUser}) : super(key: key);
  final bool oldUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: oldUser ? '1' : 'on',
        routes: {
          'on': (context) => const OnBoarding(),
          '1': (context) => const LayoutScreen(),
          '2': (context) => const ProductDetailsScreen(),
          '3': (context) => const SelectedCategory(),
        },
      ),
    );
  }
}
