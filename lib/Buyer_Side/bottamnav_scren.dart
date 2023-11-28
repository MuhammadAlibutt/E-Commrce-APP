import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Auth/SignUp.dart';
import 'Auth/accoount.dart';
import 'Page/Add_To_WishList/addtowishlist.dart';
import 'Page/Add_to_Cart/add_to_cart.dart';
import 'Page/Category/category.dart';
import 'Page/Chat_Modul/chat_app.dart';
import 'Page/Chat_Modul/chat_screen.dart';
import 'Page/Products/cards.dart';
import 'Page/chat Module/message.dart';
import 'Side_Bar/SideBar.dart';



class BottomNavBar extends StatefulWidget {
  var currentIndex;
  BottomNavBar({super.key , this.currentIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  var _index = 0;
  void checkCurrentIndex(_currentIndex){
    setState(() {
      _index = _currentIndex;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentIndex(widget.currentIndex);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Exlpore',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: (){
                      Get.to(const AddToWishList());
                    },
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.black,
                    ),
                ),

              ],
            ),
          )
        ],
      ),
      body: Center(
        child: _index== 0
            ? const Products()
            :  _index == 1
            ? const Category()
            :  _index == 2
            ? const ChatScreen()
            :  _index == 3
            ? const AccountScreen()
            : const Text('No data'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          currentIndex: _index,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          selectedItemColor: Colors.orange,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                  size: 20,
                ),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.messenger_sharp, size: 15), label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 20,
                ),
                label: 'Account'),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddToCartPage());
        },
        child: const Icon(Icons.shopping_cart),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
