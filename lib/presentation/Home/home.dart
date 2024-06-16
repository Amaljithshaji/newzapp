
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzapp/presentation/favorite_screen/favorite_screen.dart';
import 'package:newzapp/presentation/search_screen/search_screen.dart';
import '../../../core/controller/home_controller.dart';
import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';
import 'home_screen.dart';


class Home extends StatelessWidget {
  Home({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeScreen(),
       const SearchScreen(),
       const FavoriteScreen()
      
    ];
    return Obx(
      () => Scaffold(
        body: pages[homeController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
            unselectedLabelStyle: appFont.f14w400Grey,
            selectedLabelStyle: appFont.f14w600Brand,
            elevation: 10,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: appColors.brandDark,
            currentIndex: homeController.currentIndex.value,
            onTap: (value) {
              homeController.onChangedIndex(value);
            },
            items: List.generate(pages.length, (index) {
              return BottomNavigationBarItem(
                  icon: Icon(
                    bottomBarIcons[index],
                    size: 29,
                  ),
                  label: labels[index]);
            })),
      ),
    );
  }
}

List<IconData> bottomBarIcons = [
  Icons.home,
  Icons.search_rounded,
  Icons.favorite
  
];
List<String> labels = ['Home','Search','Favorite'];
