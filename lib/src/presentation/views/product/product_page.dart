import 'package:ecommerce_app/src/presentation/views/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late double deviceHeight, deviceWidth;
  List<Color> colors = [
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.yellow,
  ];
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProductBloc>(context).add(
                        AddToFavorites(p: state.p),
                      );
                    },
                    child: (state.p.favorite)
                        ? Icon(MdiIcons.heart)
                        : Icon(MdiIcons.heartOutline),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductLoading) {
            return SizedBox(
              height: deviceHeight,
              width: deviceWidth,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is ProductLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    BlocProvider.of<ProductBloc>(context).add(
                      AddToFavorites(p: state.p),
                    );
                  },
                  child: SizedBox(
                    height: deviceWidth,
                    width: deviceWidth,
                    child: PageView.builder(
                      itemCount: state.p.images.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(state.p.images[index]),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.p.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${state.p.price}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: Text(
                    state.p.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceWidth * 0.19 + 40,
                  width: deviceWidth,
                  // margin: EdgeInsets.symmetric(),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: deviceWidth * 0.19,
                        width: deviceWidth * 0.19 - 1,
                        margin: (index == 0 || index == colors.length - 1)
                            ? EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                left: (index == 0) ? 20 : 10,
                                right: (index == colors.length - 1) ? 20 : 10,
                              )
                            : const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 20,
                                bottom: 20,
                              ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: colors[index],
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: deviceWidth,
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "Buy now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
