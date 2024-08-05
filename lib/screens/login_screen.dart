import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:l_m_store/screens/register_screen.dart';
import 'package:l_m_store/screens/task_layout.dart';

import '../dio/api_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visibale = true;
  var formkey = GlobalKey<FormState>();
  late TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    namecontroller.dispose();
    passwordcontroller.dispose();
  }

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
          padding: const EdgeInsets.only(top: 70),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  color: Colors.white38.withOpacity(.6),
                  child: Padding(
                    padding: const EdgeInsets.only(left:10,right: 10),
                    child: Column(
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF663088),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "User name must not be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xe6e073af),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xE6663088),
                          ),
                        ),

                        labelText: "User Name",
                        labelStyle: TextStyle(
                          color: Color(0xFF663088),
                        ),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person,color: Color(0xe6e073af),),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordcontroller,
                      obscureText: visibale,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xe6e073af),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xE6663088),
                          ),
                        ),

                        labelText: "Passsword",
                        labelStyle: const TextStyle(
                          color:Color(0xFC663088),
                        ),
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock,color:Color(0xe6e073af)),
                        suffixIcon: IconButton(
                            color:const Color(0xe6e073af),
                          onPressed: () {
                            setState(() {
                              visibale = !visibale;
                            });
                          },
                          icon: Icon(
                              visibale ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: 390,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xE6663088),
                    //const Color(0xffE3A5C7),
                  ),
                   child: MaterialButton(
                     onPressed: () async {
                       if (formkey.currentState!.validate()) {
                         String message = await ApiProvider().userLogin(
                           username: namecontroller.text,
                           password: passwordcontroller.text,
                         );
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                           backgroundColor: Color(0x6B8047A2)
                           ,content: Text(message,),),);

                         if (message == "Login Success") {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => const HomeLayout(),),
                           );
                         }
                       }
                     },
                     child: const Text(
                       "Login",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 25,
                       ),
                     ),
                   ),
                ),
                Container(
                  color: Colors.white38.withOpacity(.6),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don`t have an account?",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: const Text(
                            "Rigster",
                            style: TextStyle(
                              color: Color(0xFF663088),
                              fontFamily: 'Gilory Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  )
                    ],
                              ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
