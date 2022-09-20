import 'package:ecommerce_store/cubit/cubit.dart';
import 'package:ecommerce_store/cubit/state.dart';
import 'package:ecommerce_store/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var titleCont = TextEditingController();

  var priceCont = TextEditingController();

  var descriptionCont = TextEditingController();

  var category = TextEditingController();

  var imgUrlCont = TextEditingController();

  var selectedcont = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();


  String selectedCategory = "electronics";

  List <String> categoryList = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener:(context,state){},
      builder: (context,state){return Scaffold(
        body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTFF('- title',cont: titleCont),
                  buildTFF('- price',cont: priceCont),
                  buildTFF('- description',cont:descriptionCont),
                  buildTFF('- Link of image',cont: imgUrlCont),
                  buildTFF('- selectedCategory',cont: selectedcont, widget: DropdownButton(
                      underline: Container(
                        height: 0,
                      ),
                      value: selectedCategory,
                      dropdownColor: Colors.blueGrey,
                      items: categoryList
                          .map<DropdownMenuItem<String>>((String e) =>
                          DropdownMenuItem<String>(
                              value: e.toString(), child: Text(e.toString())))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value.toString();
                        });
                      })),
                  InkWell(
                    onTap: (){
                      if(formKey.currentState!.validate()) {
                        HomeCubit.get(context).addProduct(titleCont.text, priceCont.text, descriptionCont.text, imgUrlCont.text, selectedcont.text);
                      }
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.all(30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                          child: Text(
                            'add Product',
                            style: primaryStyle.copyWith(color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
            )),
      );},
    );
  }

  Padding buildTFF(txt,{widget,cont}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            txt,
            style: primaryStyle,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  readOnly: widget==null ? false : true,
                  controller: cont,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'it can\'t be null';
                  //   }
                  // }

                  decoration: InputDecoration(
                    suffixIcon: widget,
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

