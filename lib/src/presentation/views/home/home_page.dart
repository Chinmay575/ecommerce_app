import 'dart:async';

import 'package:ecommerce_app/src/domain/models/category.dart';
import 'package:ecommerce_app/src/domain/models/product.dart';
import 'package:ecommerce_app/src/presentation/views/home/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/presentation/views/product/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double deviceHeight, deviceWidth;

  late Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage % 4,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      },
    );
    BlocProvider.of<HomeBloc>(context).add(IntialFetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: Container(
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            child: const CircleAvatar(
              radius: 5,
              backgroundImage: AssetImage(
                "assets/images/james-person-1.jpg",
              ),
            ),
          ),
          title: const Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                "Krishna SN",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                child: const Icon(
                  Icons.notifications,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                child: const Icon(Icons.menu),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  showCursor: false,
                  decoration: InputDecoration(
                    hintText: "Search for product",
                    iconColor: Colors.grey.shade600,
                    prefixIconColor: Colors.grey.shade600,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 24,
                    ),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: deviceWidth,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: PageView.builder(
                  controller: _pageController,
                  // onPageChanged: (index) {},
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: deviceWidth,
                      width: deviceWidth,
                      child: Image.asset(
                        "assets/images/${(_currentPage % 4) + 1}.jpeg",
                      ),
                    );
                  },
                ),
              ),
              BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is CategoriesLoaded) {
                    context.read<HomeBloc>().add(
                        GetProducts(categories: state.categories, category: 0));
                  }
                },
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is CategoriesLoaded) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: deviceWidth,
                          child: showCategories(state.categories, 0),
                        ),
                      ],
                    );
                  } else if (state is ProductsLoading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: deviceWidth,
                          child:
                              showCategories(state.categories, state.current),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.3,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    );
                  } else if (state is ProductsLoaded) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: deviceWidth,
                          child: showCategories(
                            state.categories,
                            state.current,
                          ),
                        ),
                        SizedBox(
                          height: 100.0 * state.products.length,
                          width: deviceWidth,
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 250,
                            ),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              return productView(index, state.products);
                            },
                          ),
                          // child:,
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showCategories(List<Category> categories, int current) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        bool selected = (index == current);
        return GestureDetector(
          onTap: () {
            context.read<HomeBloc>().add(
                  GetProducts(
                    categories: categories,
                    category: (index == 0) ? 0 : categories[index].id,
                  ),
                );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            margin: (index == 0 || index == categories.length - 1)
                ? EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: (index == 0) ? 20 : 5,
                    right: (index == categories.length - 1) ? 20 : 5)
                : const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: (selected) ? Colors.black : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                categories[index].name,
                style: TextStyle(
                  color: (selected) ? Colors.white : Colors.grey.shade800,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget productView(int index, List<Product> products) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductBloc>(context).add(
          GetProductDetails(p: products[index]),
        );
        Navigator.pushNamed(context, AppRouteStrings.product);
      },
      child: Container(
        height: deviceHeight * 0.2,
        margin: (index % 2 == 0)
            ? const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 10,
                bottom: 10,
              )
            : const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 20,
                bottom: 10,
              ),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurStyle: BlurStyle.outer,
              blurRadius: 0.5,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            // vertical: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width: deviceWidth * 0.5 - 30,
                margin: const EdgeInsets.only(top: 10),
                child: Image.network(
                  products[index].images[0],
                ),
              ),
              Text(
                products[index].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                products[index].description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "\$${products[index].price}",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
