
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../dio/api_provider.dart';
import 'package:l_m_store/widgets/categories.dart';
import '../models/products_models.dart';
import 'infoapp_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  ApiProvider? apiProvider;
  ProductsModel? productModel;
  @override
  void initState() {
    super.initState();
   // getProducts();
    loadProducts();

  }
  loadProducts() async {
    setState(() {
      isLoading = true;
    });
    productModel= await ApiProvider().getProducts();
    setState(() {
      isLoading = false;
    });
  }

  getProducts() async {
    productModel= await ApiProvider().getProducts();
    print(productModel?.products![0].title);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InfoappScreen()));
                  },
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  iconSize: 30,
                  icon: const Icon(Icons.grid_view_rounded,color: Color(0x6B8047A2),),
                ),
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  iconSize: 30,
                  icon: const Icon(Icons.notifications_active_rounded,color: Color(0x6B8047A2) ),
                ),
              ],
            ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xa9faaeca),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10,top:7 ,bottom:7),
                        child: Icon(Icons.search, color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                 Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 180,
                        width:double.infinity,
                        child: AnotherCarousel(images: const [
                          AssetImage('assets/images/Go.jpg',),
                          AssetImage('assets/images/11.jpg',),
                          AssetImage('assets/images/13.jpg',),
                        ],
                        indicatorBgPadding: 3,
                        dotIncreasedColor:Colors.white,
                        dotBgColor:const Color(0x3dfaa6c5),
                        dotColor: const Color(0xed663685)
                        ,dotSize: 8,),
                      )
                      ,const SizedBox(height: 10,)

                    ],
                  ),

                const Categories(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Special For You",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("See all"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount:10,
                      itemBuilder: (context, index) {
                        return ProductCard(product: productModel!.products![index]);

                      },
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


Widget ProductCard({required Product product}) {
  return Stack(
    children: [
      Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0x69faaeca),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image
              (image: NetworkImage(product.images![0]),
              width: 100,
              height: 100,
            ),
            Text(
              product.title!, maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "\$${product.price.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0x6B8047A2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: const Icon(
              CupertinoIcons.heart,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    ],
  );
}