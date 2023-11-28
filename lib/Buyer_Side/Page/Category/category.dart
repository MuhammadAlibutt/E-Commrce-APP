import 'package:fahioapp_fyp/Buyer_Side/Page/Category/woman_category_screens/Womencategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Boy_category_screens/boy_category.dart';
import 'girl_category_screens/girlcategory.dart';
import 'man_category_screens/MenCatgory.dart';


class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  categories(Color col, String catName, img, page) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          print('select category $page');
        Get.to( page);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.94,
          decoration: BoxDecoration(
              color: col, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  catName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  img,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Category',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          categories(Color.fromARGB(255, 167, 123, 174), 'Boys Fashion',
              'assets/images/boy.png', const BoyCategory()),
          categories(Color.fromARGB(255, 180, 171, 91), 'Girls Fashion',
              'assets/images/girl.png', const GirlCollection()),
          categories(Color.fromARGB(255, 173, 205, 230), 'Woman Collection',
              'assets/images/woman.png', const WomenCollection()),
          categories(Color.fromARGB(255, 93, 175, 242), 'Man Collection',
              'assets/images/man.png', const ManCollection()),
        ],
      ),
    );
  }
}


