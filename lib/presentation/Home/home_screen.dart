import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzapp/manager/color_manager.dart';
import 'package:newzapp/manager/font_manager.dart';

//import 'package:newzfeedz/view/Notification/NotificationScreen.dart';

//import 'package:newzfeedz/view/profile/profile.dart';

import '../../widgets/home_widgets/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: appColors.brandDark,
              title: Text(
                'Newz App',
                style: appFont.f20w500white,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed('/favoriteScreen');
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
              bottom: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade100,
                      fontWeight: FontWeight.w500),
                  labelColor: Colors.white,
                  tabs: List.generate(
                    categoryList.length,
                    (index) => Tab(
                      text: categoryList[index],
                    ),
                  )),
            ),
            body: TabBarView(
                children: List.generate(
              categoryList.length,
              (index) => Container(
                width: double.infinity,
                color: Colors.white,
                child: Category(
                  category: categoryList[index],
                ),
              ),
            ))));
  }
}

List<String> categoryList = [
  'General',
  'Technology',
  'Science',
  'Sports',
  'Health',
  'Business',
  'Entertainment',
];
