import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({super.key});

  @override
  State<Introscreen> createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  Widget dotpageview (){
    return Builder(builder: ((context){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for(int i=0;i<2;i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: i==pageNumber? 25 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color:i==pageNumber? const Color(0xff653e3e):  const Color(0xbb653e3e),//Color(0xff653e3e)
              ),
            ),
        ],
      );
    }));
  }
  PageController nextpage = PageController();
  int pageNumber=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xfff6efb4),
      body: PageView(
        onPageChanged: (value){
          setState(() {
            pageNumber= value;
          });
        },
        controller: nextpage,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/6.png',
                    color: const Color(0x99663685),
                    //fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Image.asset(
                      'assets/images/2.png',
                      color: const Color(0x99663685),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 100,
                    ),
                    child: Image.asset(
                      'assets/images/2.png',
                    ),
                  ),
                ],
              ),
              const Text('L&M Store',
                  style: TextStyle(
                      color: Color(0x99663685),
                      fontFamily: 'Gilory',
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Enjoy shopping with us ,We add fun to shopping',
                  style: TextStyle(
                    color: Color(0xff4C2C2C),
                    fontFamily: 'Gilory Pro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  nextpage.animateToPage(1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                },
                child: Container(
                  width: 300,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0x99663685), //Color(0xffFF99C1)
                  ),
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilory Pro',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              dotpageview()
            ],
          ),
          Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                      'assets/images/7.png',
                      color: const Color(0xff998FC9),//Color(0x99663685),
                    ),

                  Padding(
                    padding: const EdgeInsets.only(top: 60,left: 20),
                    child: Image.asset(
                      'assets/images/7.png',
                      color: const Color(0xfff6b1cb),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 100, right: 25, left: 25),
                    child: Image.asset(
                      'assets/images/1.png',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('Vouchers and cash back',
                  style: TextStyle(
                     color: Color(0xe6e073af), //color: Color(0xfff688b1),
                      fontFamily: 'Gilory',
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'what are you waiting for!\n Register now',
                  style: TextStyle(
                    //backgroundColor:Color(0xffFF99C1),
                    // decoration: TextDecoration.underline,
                    // decorationColor: Colors.white,
                    color: Color(0xff4C2C2C),
                    fontFamily: 'Gilory Pro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                },
                child: Container(
                  width: 300,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                      color: const Color(0xfff6b1cb), //Color(0xffFF99C1)
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilory Pro',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              dotpageview()
            ],
          )
        ],
      )
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('on bording', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
