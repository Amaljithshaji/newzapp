import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:newzapp/core/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:newzapp/manager/color_manager.dart';
import 'package:newzapp/manager/font_manager.dart';
import 'package:newzapp/widgets/newz_card.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoritesCubit>(context).loadFavorites();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Favorite',
          style: appFont.f20w500white,
        ),
        backgroundColor: appColors.brandDark,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoritesLoaded) {
            
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: [
                ResponsiveGridList(
                  listViewBuilderOptions: ListViewBuilderOptions(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics()),
                  minItemWidth: 70,
                  maxItemsPerRow: 1,
                  verticalGridSpacing: 10,
                  horizontalGridSpacing: 10,
                  children: List.generate(state.favorites.length, (index) {
                    final articleModel = state.favorites[index];
                    final article = articleModel.toArticle();
                    return InkWell(
                      onTap: () {
                        Get.toNamed('/detailsScreen',
                            arguments: {'article': article});
                      },
                      child: NewzCard(
                        article: article,
                      ),
                    );
                  }),
                )
              ],
            );
          } else if (state is FavoritesError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const Center(
            child: Text('no data'),
          );
        },
      ),
    );
  }
}
