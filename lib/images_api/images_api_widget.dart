import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/images_api/wallpaper_set_widget.dart';
import 'package:http/http.dart' as http;

class ImagesApiWidget extends StatefulWidget {
  const ImagesApiWidget({super.key});

  @override
  State<ImagesApiWidget> createState() => _ImagesApiWidgetState();
}

class _ImagesApiWidgetState extends State<ImagesApiWidget> {
  List images = [];
  bool isLoading = false;
  int currentPage = 1;

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
    // TODO: implement initState
    super.initState();
    fetchApi();
  }

  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Wallpaper"),
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
                      // }
                      // return Container(
                      //   margin: EdgeInsets.symmetric(vertical: 40),
                      //   height: 50,
                      //   child: FilledButton(
                      //       style: ButtonStyle(
                      //           backgroundColor:
                      //               WidgetStatePropertyAll(Colors.transparent),
                      //           foregroundColor:
                      //               WidgetStatePropertyAll(Colors.black)),
                      //       onPressed: () {
                      //         setState(() {
                      //           isLoading = true;
                      //         });
                      //         fetchApi();
                      //       },
                      //       child: Text("Load More...")),
                      // );
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Hero(
                          tag: images[index]["download_url"],
                          child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: ClipRRect(
                                key: ValueKey(images[index]["download_url"]),
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  cacheKey: images[index]["download_url"],
                                  key: ValueKey(images[index]["download_url"]),
                                  imageUrl: images[index]["download_url"],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error, size: 50),
                                  placeholder: (
                                    context,
                                    value,
                                  ) {
                                    return Container(
                                      color: Colors.grey[200],
                                    );
                                  },
                                ),
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}
