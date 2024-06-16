import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:newzapp/core/cubit/search_cubit/search_cubit.dart';
import 'package:newzapp/manager/space_manger.dart';
import 'package:newzapp/widgets/newz_card.dart';

import 'package:responsive_grid_list/responsive_grid_list.dart';
//import 'package:newzfeedz/view/Home/widgets/db.dart';

import '../../manager/font_manager.dart';
import '../../utils/get_dimension.dart';
//import 'widgets/Recent.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool iselected = false;
  bool isSelected = false;
  List<String> searchOptions = [
    'General'
        'Tech',
    'Science',
    'Sports',
    'Health',
    'Business',
    'Entertainment',
  ];

  @override
  void initState() {
    context.read<SearchCubit>().searchNews(
        search:
            _searchController.text.isEmpty ? 'all' : _searchController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: appColors.brandDark,
        title: Container(
          height: screenHeight(context) * 0.06,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              context
                  .read<SearchCubit>()
                  .searchNews(search: _searchController.text);
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search',
                hintStyle: appFont.f14w400Grey,
                border:
                    const UnderlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchSuccessState) {
              return ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                children: [
                  appSpaces.spaceForHeight30,
                  ResponsiveGridList(
                    listViewBuilderOptions: ListViewBuilderOptions(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics()),
                    minItemWidth: 70,
                    maxItemsPerRow: 1,
                    verticalGridSpacing: 10,
                    horizontalGridSpacing: 10,
                    children: List.generate(state.news.length, (index) {
                      final result = state.news[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed('/detailsScreen',
                              arguments: {'article': result});
                        },
                        child: NewzCard(
                          article: result,
                        ),
                      );
                    }),
                  )
                ],
              );
            } else if (state is SearchErrorState) {
              return Center(
                child: Text(state.error),
              );
            }

            return Center(
              child: Text(
                'No data Found',
                style: appFont.f16w500Black,
              ),
            );
          },
        ),
      ),
    );
  }
}
