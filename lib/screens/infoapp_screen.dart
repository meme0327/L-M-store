import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:l_m_store/screens/task_layout.dart';

import 'info_screen.dart';

class InfoappScreen extends StatelessWidget {

  const InfoappScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/10.png',
                ),
                fit: BoxFit.cover,
                colorFilter:ColorFilter.linearToSrgbGamma()
            )),
        child: Padding(
          padding: const EdgeInsets.only(top: 59,bottom: 54),
          child: Container(
            color: Colors.white38.withOpacity(.5),
            child: Column(
              children: [
                  Column(
                      children: [
                        SizedBox(width: 10,),
                            Icon(CupertinoIcons.heart_circle,size: 60,color: Color(0xffe073af),),
                        Text(textAlign: TextAlign.center,' L&M store',
                          style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Color(0xffe073af)),),
                        SizedBox(height: 15,),
                        Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: Container(
                            color: Color(0x99e073af),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Text(textAlign: TextAlign.center,' \nIs a store that provides you with '
                                  'many sections and products for you to shop between with '
                                  'enjoyment and comfort from the comfort of your home '
                                  'without any effort. \n Just click a button and enjoy your new items. '
                                  'It is designed in a way that suits your pleasant taste and to '
                                  'move with great comfort between all the pages, \n Enjoy.\n',
                                style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                      ],
                    ),

                 SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeLayout()));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.home, size: 35, color: Color(0xffe073af)),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          )
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoScreen()));
                        },
                        child: const Text(
                          textAlign: TextAlign.center,
                          'Next',
                          style: TextStyle(
                            color: Color(0xffe073af),
                            fontFamily: 'Gilory Pro',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ),
                    ],
                  ),
                ),



            ],),
          ),
        ),
      ),
    );
  }
}