import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../bottamnav_scren.dart';
import 'All_Products_Man.dart';
import 'Man_Jacket.dart';
import 'Women_Other.dart';
import 'Women_Pent.dart';
import 'Women_shoes.dart';
import 'Women_Shorts.dart';
import 'Women_Shirt.dart';

class WomenCollection extends StatefulWidget {
  const WomenCollection({super.key});

  @override
  State<WomenCollection> createState() => _WomenCollectionState();
}

class _WomenCollectionState extends State<WomenCollection> {
  int _currentIndex = 0;

  _onTapIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Woman Fashion',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(BottomNavBar(currentIndex: 1,));
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Categories',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          _categorybar(),
          _currentIndex == 0
              ? const AllWomenProducts()
              : _currentIndex == 1
              ? const WomenShirtProduct()
              : _currentIndex == 2
              ? const WomenPantProduct()
              : _currentIndex == 3
              ? const MenJacketPoduct()
              : _currentIndex == 4
              ? const WomenShortsProducts()
              : _currentIndex == 5
              ? const WomenShoesProduct()
              : const WomenOtherProducts()
        ]),
      ),
    );
  }

  Widget _buildBarItem(int index, String label) {
    return InkWell(
      onTap: () {
        _onTapIndex(index);
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  _categorybar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildBarItem(0, 'All'),
          const SizedBox(
            width: 20,
          ),
          _buildBarItem(1, 'Shirts'),
          const SizedBox(
            width: 20,
          ),
          _buildBarItem(2, 'Pents'),
          const SizedBox(
            width: 20,
          ),
          _buildBarItem(3, 'Jackets'),
          const SizedBox(
            width: 20,
          ),
          _buildBarItem(4, 'Shorts'),
          const SizedBox(
            width: 20,
          ),
          _buildBarItem(5, 'shoes'),
          const SizedBox(
            width: 20,
          ),
          _buildBarItem(6, 'Cap and other'),
        ],
      ),
    );
  }

}
