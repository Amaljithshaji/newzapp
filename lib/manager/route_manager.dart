
import 'package:get/get.dart';
import 'package:newzapp/presentation/details_screen/detail_screen.dart';
import 'package:newzapp/presentation/favorite_screen/favorite_screen.dart';
import 'package:newzapp/presentation/splash/splash.dart';

import '../presentation/Home/home.dart';





List<GetPage<dynamic>> appRoute() {
  return [

    GetPage(
      name: "/",
      page: () => const Splash(),
    ),
   
    GetPage(
      name: "/Home",
      page: () =>  Home(),
    ),
     GetPage(
      name: "/detailsScreen",
      page: () =>  DetailScreen(
        article: Get.arguments['article'],
       
      ),
    ),
     GetPage(
      name: "/favoriteScreen",
      page: () => const FavoriteScreen(),
    ),
  ];
}
