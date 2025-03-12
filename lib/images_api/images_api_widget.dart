import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/images_api/wallpaper_set_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImagesApiWidget extends StatefulWidget {
  const ImagesApiWidget({super.key});

  @override
  State<ImagesApiWidget> createState() => _ImagesApiWidgetState();
}

class _ImagesApiWidgetState extends State<ImagesApiWidget> {
  List images = [];
  bool isLoading = false;
  int currentPage = 1;

  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  fetchApi() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      await http
          .get(Uri.parse(
              "https://picsum.photos/v2/list?page=$currentPage&limit=10"))
          .then(
        (value) {
          List myData = jsonDecode(value.body);
          print(myData);
          setState(() {
            images.addAll(myData);
          });
          setState(() {
            isLoading = false;
            currentPage++;
          });
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Wallpaper", style: GoogleFonts.raleway(
            fontWeight: FontWeight.w500,
            color: Colors.black
          )),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        backgroundColor: Colors.white,
        body: images.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    // at List end
                    fetchApi();
                  }
                  return false;
                },
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: images.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == images.length) {
                      // if (isLoading) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WallpaperSetWidget(
                              image: images[index]["download_url"],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200
                          ),
                          child: Hero(
                            tag: images[index]["download_url"],
                            child: AspectRatio(
                              aspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * 0.7),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  cacheKey: images[index]["download_url"],
                                  imageUrl: images[index]["download_url"],
                                  fit: BoxFit.cover,
                                  // memCacheWidth: 1500,
                                  // memCacheHeight: 1000,
                                  cacheManager: _cacheManager,
                                  useOldImageOnUrlChange: true,
                                  errorWidget: (context, url, error) => Container(
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        size: 50,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, value) {
                                    return Shimmer.fromColors(baseColor: Colors.grey.shade200, highlightColor: Colors.white, child: Container(
                                      color: Colors.white,
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}
