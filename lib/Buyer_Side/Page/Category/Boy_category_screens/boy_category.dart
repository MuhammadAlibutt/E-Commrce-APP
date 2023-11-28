import 'package:fahioapp_fyp/Buyer_Side/bottamnav_scren.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import 'categoory_boyshoes_product.dart';
import 'category_all_product.dart';
import 'category_boyjacket_produc.dart';
import 'category_boyother_product.dart';
import 'category_boypent_productsa.dart';
import 'category_boyshirt_product.dart';
import 'category_boyshort_product.dart';

class BoyCategory extends StatefulWidget {
  const BoyCategory({super.key});

  @override
  State<BoyCategory> createState() => _BoyCategoryState();
}

class _BoyCategoryState extends State<BoyCategory> {
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
          'Boys Fashion',
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
              ? const AllProduct()
              : _currentIndex == 1
              ? const ManProducts()
              : _currentIndex == 2
              ? const BoyPents()
              : _currentIndex == 3
              ? const BoyJacket()
              : _currentIndex == 4
              ? const BoyShorts()
              : _currentIndex == 5
              ? const BoyShoes()
              : const BoyOtherProducts()
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
