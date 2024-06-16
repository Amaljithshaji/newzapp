import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzapp/core/models/article.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/cubit/favorites_cubit/favorites_cubit.dart';
import '../core/models/article_model.dart';
import '../manager/color_manager.dart';
import '../manager/font_manager.dart';
import '../utils/get_dimension.dart';
import 'package:intl/intl.dart';

class NewzCard extends StatefulWidget {
  const NewzCard({super.key, required this.article});
  final Article article;

  @override
  State<NewzCard> createState() => _NewzCardState();
}

class _NewzCardState extends State<NewzCard> {
  bool isSelected = false;

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final FavoritesCubit favoritesCubit =
        BlocProvider.of<FavoritesCubit>(context);
    final isFavorite = favoritesCubit.isFavorite(widget.article.url);
    return Container(
      width: screenWidth(context),
      height: 320,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 170,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              // border: Border.all(
              //     width: 2, color: Colors.black),
              // image: DecorationImage(image: AssetImage(appImages.errorImage),fit: BoxFit.fill)
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.article.imageUrl,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
          ),
          Container(
            width: screenWidth(context) * 0.9,
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              widget.article.title,
              style: appFont.f16wBoldBlack,
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.article.sourceName),
                Text(widget.article.publishedAt.toString())
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    final articleModel =
                        ArticleModel.fromArticle(widget.article);
                    if (isFavorite) {
                      favoritesCubit.removeFavorite(articleModel);
                    } else {
                      favoritesCubit.addFavorite(articleModel);
                    }
                    setState(() {});
                  },
                  icon: isFavorite == false
                      ? Icon(
                          Icons.favorite_border_outlined,
                          color: appColors.brandDark,
                        )
                      : Icon(
                          Icons.favorite,
                          color: appColors.brandDark,
                        )),
              IconButton(
                  onPressed: () {
                    Share.share(widget.article.url);
                  },
                  icon: Icon(
                    Icons.share,
                    color: appColors.brandDark,
                  )),
              TextButton(
                onPressed: () {
                  launchUrl(Uri.parse(widget.article.url.toString()),
                      mode: LaunchMode.inAppWebView);
                },
                child: const Text(
                  'Read More',
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
