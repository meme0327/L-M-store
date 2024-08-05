import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../dio/api_provider.dart';
import '../models/products_cat.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  int selectedIndex = 0;
  List<String> categories = [];
  ProductsOfCategoryModel? productsOfCategoryModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  loadCategories() async {
    categories = await ApiProvider().getCategories();
    if (categories.isNotEmpty) {
      await loadProducts(categories[0]);
    }
    setState(() {
      isLoading = false;
    });
  }

  loadProducts(String category) async {
    setState(() {
      isLoading = true;
    });
    productsOfCategoryModel =
        await ApiProvider().getProductsByCategory(category);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/10.png',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.linearToSrgbGamma())),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xAE8047A2),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.search,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                     const Text(
                      "Categories",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xEC8047A2),
                        fontSize: 25,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xAE8047A2),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          CupertinoIcons.camera_viewfinder,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                            child: buildCategories(
                                category: categories[index], index: index)),
                        const SizedBox(height: 5),
                      ],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 21,
                    ),
                    itemCount: categories.length,
                  ),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => buildProductItem(
                              product:
                                  productsOfCategoryModel!.products![index]),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: productsOfCategoryModel!.products!.length,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategories({required String category, required int index}) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        loadProducts(category);
      },
      child: Container(
        height: 35,
        width: 157,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: const Border.symmetric(
              horizontal: BorderSide(color: Color(0xAE8047A2), width: 1),
              vertical: BorderSide(color: Color(0xAE8047A2), width: 6)),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: selectedIndex == index ? const Color(0xAE8047A2) : Colors.white60,
        ),
        child: Text(
          textAlign: TextAlign.center,
          category,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.7,
            color: selectedIndex == index ? Colors.white : const Color(0xFF823FA9),
          ),
        ),
      ),
    );
  }

  Widget buildProductItem({required Product product}) {
    return Container(
      height: 177,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        top: 19,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white38.withOpacity(.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: Image.network(
                product.thumbnail!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 0.7),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "price : ",
                                  style: TextStyle(
                                      color: Color(0xffde5ba3),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${product.price!.toString()} \$",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "category: ",
                                  style: TextStyle(
                                      color: Colors.black, //(0xffde5ba3),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  product.category!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color(0xFF823FA9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                ),
                              ],
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: const Color(0xAE8047A2),
                                      borderRadius: BorderRadius.circular(30)
                                      // topRight: Radius.circular(20),
                                      // bottomLeft: Radius.circular(10),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
