import 'package:flutter/material.dart';
import 'package:intro_app_ui/utils/strings.dart';

import 'home_page.dart';

class IntroPage extends StatefulWidget {
  static const String id = 'intro_page';

  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController? _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,

            children: [
              makePage(
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent,
                  image: 'assets/images/image_1.png'
              ),
              makePage(
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent,
                  image: 'assets/images/image_2.png'
              ),
              makePage(
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent,
                  image: 'assets/images/image_3.png'
              ),
            ],
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ..._buildIndicator(),

              ]
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if(currentIndex == 2)...{
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, HomePage.id);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 300),
                    child: Text('Skip',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.w400),),
                  ),
                ),
              }
            ],
          )
        ],
      ),
    );
  }

  Widget makePage({title, content, image, reverse = false}) {
    return Container(
      padding: const EdgeInsets.only(right: 50, left: 50, top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(image),
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}

/*
* if(page == 3){
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, HomePage.id);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20,left: 20),
                          child: Text('Skip',style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.w400),),
                        ),
                      ),
                    ],
                  );
                }
* */
