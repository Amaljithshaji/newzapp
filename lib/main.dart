import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzapp/core/cubit/news_cubit/news_cubit.dart';
import 'package:newzapp/core/repo/getnews_repo.dart';
import 'package:newzapp/core/repo/search_repo.dart';
import 'package:newzapp/utils/get_primarySwatch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/cubit/favorites_cubit/favorites_cubit.dart';
import 'core/cubit/search_cubit/search_cubit.dart';
import 'core/models/article_model.dart';
import 'manager/color_manager.dart';
import 'manager/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  await Hive.openBox<ArticleModel>('favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NewsRepo(),
        ),
         RepositoryProvider(
          create: (context) => SearchRepo(),
        ),
       
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsCubit(repo: NewsRepo()),
          ),
           BlocProvider(
            create: (context) => SearchCubit(repo: SearchRepo()),
          ),
          BlocProvider(
          create: (context) => FavoritesCubit(Hive.box<ArticleModel>('favorites')),
        ),
        ],
        child:  GetMaterialApp(
                  title: 'Newz App',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: getMaterialColor(appColors.brandDark),
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: appColors.brandDark),
                    bottomSheetTheme:
                        const BottomSheetThemeData(backgroundColor: Colors.white),
                    useMaterial3: true,
                  ),
                  getPages: appRoute(),
                 initialRoute: '/',
                  //  home: DetailScreen(itemIndex: 1,),
                
      ),
    ));
  }
}

