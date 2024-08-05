import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dio/api_provider.dart';
import '../models/user_models.dart';

class ProfileScreen extends StatefulWidget {
  // final String name;
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  fetchUser() async {
    final apiProvider = ApiProvider();
    final user = await apiProvider.getUser();

    setState(() {
      userModel = user;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //TextEditingController _name = TextEditingController(text: name);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/10.png',
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.linearToSrgbGamma())),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 120),
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTeXNhELXRdeemXH-5km_7UxZnOOYxQS28L8ruXSb2ZwCG24t1A"),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isLoading == true
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  userModel!.username!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                      color:  Color(0x99663685)//CC707C
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  userModel!.email!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ]),
          const SizedBox(height: 15),
          itemprofile("Person information", "name,mail,location,phone",
              CupertinoIcons.person),
          const SizedBox(
            height: 10,
          ),
          itemprofile("Cart", " item want to pay", CupertinoIcons.cart),
          const SizedBox(
            height: 10,
          ),
          itemprofile("Favorite", "have favorite item", CupertinoIcons.heart),
          const SizedBox(
            height: 10,
          ),
          itemprofile(
              "Setting", " can modify setting", CupertinoIcons.settings),
        ],
      ),
    );
  }

  itemprofile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: const Color.fromARGB(255, 250, 153, 185).withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 1,
            )
          ]),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        leading: Icon(iconData,color: Color(0x8C8047A2)),
        trailing: Icon(Icons.arrow_forward_ios, color: Color(0x808047A2)),
        tileColor: Colors.white,
      ),
    );
  }
}
