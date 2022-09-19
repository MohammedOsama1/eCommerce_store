import 'package:ecommerce_store/helpers/shared_pref.dart';
import 'package:ecommerce_store/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'on_model.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnModel> boardingList = [
    OnModel(
        'On Boarding 1',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
        'assets/on1.jpg'),
    OnModel(
        'On Boarding 2',
        'when an unknown printer took a galley of type and scrambled it to make a type specimen book., ',
        'assets/on2.jpg'),
    OnModel(
        'On Boarding 3',
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s ',
        'assets/on3.png'),
  ];

  var pageCont = PageController();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => onBuilder(boardingList[index]),
                itemCount: 3,
                onPageChanged: (x) {
                  setState(() {
                    index = x;
                  });
                },
                controller: pageCont,
              ),
            ),
            SmoothPageIndicator(
              controller: pageCont,
              count: 3,
              effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.pink,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () async {
            if (index == 2)    {
              Navigator.pushNamedAndRemoveUntil(context, '1', (route) => false);
              await CashHelper.addData('oldUser?', true);

            }
            pageCont.nextPage(
                duration: const Duration(milliseconds: 666),
                curve: Curves.fastLinearToSlowEaseIn);
          },
          child: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
      ),
    );
  }

  Column onBuilder(OnModel model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.asset(model.img),
      const SizedBox(
        height: 10,
      ),
      Text(
        model.title,
        style: primaryStyle,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        model.txt,
        style: primaryStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    ]);
  }
}
