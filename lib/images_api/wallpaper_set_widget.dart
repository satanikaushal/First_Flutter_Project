import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WallpaperSetWidget extends StatefulWidget {
  var image = "";

  WallpaperSetWidget({super.key, required this.image});

  @override
  State<WallpaperSetWidget> createState() =>
      _WallpaperSetWidgetState(image: image);
}

class _WallpaperSetWidgetState extends State<WallpaperSetWidget> {
  String image;

  _WallpaperSetWidgetState({required this.image});

  bool isLoading = false;
  int location = AsyncWallpaper.HOME_SCREEN;
  setWallpaper() async {
    String result;
    setState(() {
      isLoading = true;
    });
    try {
      result = await AsyncWallpaper.setWallpaper(
        url: image,
        wallpaperLocation: location,
        goToHome: false,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            foregroundColor: Colors.white,
            forceMaterialTransparency: true,
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
          body: Center(
            child: Stack(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Hero(
                  tag: image,
                  child: ClipRRect(
                    key: ValueKey(image),
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      cacheKey: image,
                      key: ValueKey(image),
                      imageUrl: image,
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
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    margin: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!isLoading) {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  height: 250,
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 50,
                                            width: double.infinity,
                                            child: FilledButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  location = AsyncWallpaper.HOME_SCREEN;
                                                });
                                                setWallpaper();
                                              },
                                              style: ButtonStyle(
                                                  shape: WidgetStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20)))),
                                              child: Text("Home Screen", style: GoogleFonts.raleway(),),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 50,
                                            width: double.infinity,
                                            child: FilledButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    location = AsyncWallpaper.LOCK_SCREEN;
                                                  });
                                                  setWallpaper();
                                                },
                                                style: ButtonStyle(
                                                    shape: WidgetStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20)))),
                                                child: Text("Lock Screen", style: GoogleFonts.raleway(),)),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 50,
                                            width: double.infinity,
                                            child: FilledButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    location = AsyncWallpaper.BOTH_SCREENS;
                                                  });
                                                  setWallpaper();
                                                },
                                                style: ButtonStyle(
                                                    shape: WidgetStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20)))),
                                                child: Text("Both", style: GoogleFonts.raleway(),)),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                          // setWallpaper();
                        }
                      },
                      style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(10),
                          backgroundColor: WidgetStatePropertyAll(Colors.white)),
                      child: Text(
                        "Set as Wallpaper",
                        style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
        isLoading
            ? GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.black.withAlpha((255 * 0.7).toInt()),
                  child: Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
