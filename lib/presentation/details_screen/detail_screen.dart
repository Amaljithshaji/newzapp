import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newzapp/core/models/article.dart';
import 'package:newzapp/manager/font_manager.dart';
import 'package:newzapp/manager/space_manger.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/cubit/favorites_cubit/favorites_cubit.dart';
import '../../core/models/article_model.dart';
import '../../manager/color_manager.dart';

//import 'package:share_plus/share_plus.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.article});

  final Article article;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.brandDark,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          title: const Text(
            'Details',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            launchUrl(Uri.parse(widget.article.url.toString()),
                mode: LaunchMode.inAppWebView);
          },
          label: const Text(
            'Read more',
          ),
          backgroundColor: appColors.brandDark,
        ),
        body: ListView(
          children: [
            SizedBox(
                width: double.infinity,
                height: 350,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.article.imageUrl,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
            appSpaces.spaceForHeight10,
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Text(
                  widget.article.title,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            appSpaces.spaceForHeight10,
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.article.author,
              ),
            ),
            appSpaces.spaceForHeight10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.article.sourceName,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      formatDate(widget.article.publishedAt.toString()),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    )
                  ]),
            ),
            appSpaces.spaceForHeight15,
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                ],
              ),
            ),
            appSpaces.spaceForHeight30,
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.article.content,
                    style: appFont.f16w400Black,
                  )),
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
