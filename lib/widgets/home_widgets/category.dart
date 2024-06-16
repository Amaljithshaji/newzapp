import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:newzapp/core/cubit/news_cubit/news_cubit.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/models/article.dart';
import '../newz_card.dart';

class Category extends StatefulWidget {
  const Category({super.key, required this.category});
  final String category;
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final ScrollController _scrollController = ScrollController();
  List<Article> _articles = [];
  bool _isLoadingMore = false;
  @override
  void initState() {
    context.read<NewsCubit>().getNews(
          category: widget.category,
        );
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_isLoadingMore && context.read<NewsCubit>().hasMore) {
        _isLoadingMore = true;
        context.read<NewsCubit>().loadMore(category: widget.category);
      }
    } else if (_scrollController.position.pixels ==
            _scrollController.position.minScrollExtent &&
        !context.read<NewsCubit>().isFetching) {
      context.read<NewsCubit>().loadPrevious(category: widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        if (state is NewsSuccessState) {
          if (state.isRefresh) {
            _articles = state.news;
          } else {
            _articles.addAll(state.news);
          }
        } else if (state is NewsPreviousPageState) {
          _articles.insertAll(0, state.news);
        }
        _isLoadingMore = false; // Reset loading flag when done
      },
      builder: (context, state) {
        if (state is NewsLoadingState && _articles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsErrorState) {
          return Center(child: Text(state.error));
        } else {
          return _articles.isEmpty
              ? Center(
                  child: state is NewsLoadingState ||
                          state is NewsLoadingPreviousState
                      ? const CircularProgressIndicator()
                      : const Text('No articles found.'),
                )
              : ListView(
                  controller: _scrollController,
                  children: [
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        color: Colors.white,
                        child: ResponsiveGridList(
                            listViewBuilderOptions: ListViewBuilderOptions(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics()),
                            minItemWidth: 70,
                            maxItemsPerRow: 1,
                            verticalGridSpacing: 10,
                            horizontalGridSpacing: 10,
                            children: List.generate(
                                _calculateListItemCount(state), (index) {
                              if (index < _articles.length) {
                                final news = _articles[index];
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed('/detailsScreen',
                                        arguments: {'article': news});
                                  },
                                  child: NewzCard(
                                    article: news,
                                  ),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })))
                  ],
                );
        }
      },
    );
  }

  int _calculateListItemCount(NewsState state) {
    if (state is NewsSuccessState) {
      return _articles.length + (state.hasMore ? 1 : 0);
    } else if (state is NewsLoadingState ||
        state is NewsLoadingMoreState ||
        state is NewsLoadingPreviousState) {
      return _articles.length + 1;
    } else {
      return _articles.length;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}





// DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               value: selectValue,
//                               elevation: 0,
//                               iconEnabledColor: Colors.black,
//                               focusColor: Colors.black,
//                               dropdownColor:
//                                   Color.fromARGB(255, 21, 21, 21),
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(10)),
//                               enableFeedback: true,
//                               items: [
//                                 DropdownMenuItem<String>(
//                                   enabled: false,
//                                   child: TextButton(
//                                     onPressed: () {
//                                       // launchUrl(
//                                       //     Uri.parse(HomeProvider
//                                       //             .responsedata
//                                       //             ?.articles?[index]
//                                       //             .url
//                                       //             .toString() ??
//                                       //         ''),
//                                       //     mode: LaunchMode
//                                       //         .inAppWebView);
//                                     },
//                                     child: Text(
//                                       'Read more',
//                                       style: TextStyle(
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                   value: 'read more',
//                                 ),
//                                 DropdownMenuItem<String>(
//                                   child: TextButton(
//                                     onPressed: () {
//                                       // Share.share(HomeProvider
//                                       //         .responsedata
//                                       //         ?.articles?[index]
//                                       //         .url
//                                       //         .toString() ??
//                                       //     "www.google.com");
//                                     },
//                                     child: Text(
//                                       'Share',
//                                       style: TextStyle(
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                   value: 'Share',
//                                 )
//                               ],
//                               onChanged: (newValue) {
//                                 selectValue = newValue;
//                                 setState(() {});
//                               },
//                               icon: Icon(
//                                 Icons.more_vert,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                             ),
//                           )



