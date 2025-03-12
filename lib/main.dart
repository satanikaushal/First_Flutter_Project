import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/firebase_options.dart';
import 'package:flutter_demo/handling_notifications/handling_notifications_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'images_api/images_api_widget.dart';

Future<void> showNotification(RemoteMessage message, String prefix) async {
  var channelId = "channel_id";
  var channelName = "First channel";
  var notificationChannel = AndroidNotificationChannel(
    channelId,
    channelName,
    importance: Importance.high,
  );
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(notificationChannel);
  var androidDetails = AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription: "This will be the description for the channel",
    icon: "@mipmap/launcher_icon",
    importance: Importance.high,
    priority: Priority.high,
  );
  var notificationDetails = NotificationDetails(android: androidDetails);
  var title = message.data["title"] ?? "Title";
  var description = message.data["body"] ?? "Notification body";
  if (message.notification == null && message.data.isNotEmpty) {
    await flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      prefix + title,
      description,
      notificationDetails
    );
  }
}

@pragma('vm:entry-point')
Future<void> showNotificationBackground(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await showNotification(message, "Background : ");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/launcher_icon");
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse:(details) {
      print("onDidReceiveBackgroundNotificationResponse ${details.payload}");
    },
    onDidReceiveNotificationResponse: (details) {
      print("onDidReceiveNotificationResponse ${details.payload}");
    },
  );
  FirebaseMessaging.onBackgroundMessage(showNotificationBackground);
  FirebaseMessaging.onMessage.listen(
    (message) {
      showNotification(message, "Foreground : ");
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HandlingNotificationsScreen(
              title: message.data["title"] + " onMessageOpenedApp"),
        ));
      },
    );
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HandlingNotificationsScreen(
              title: value?.data["title"] + " getInitialMessage"),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black.withOpacity(0.01),
      )
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark, seedColor: Colors.green.shade700),
      ),
      home: ImagesApiWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Column(
          children: [
            Expanded(
                child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Image.network(
                          "https://www.sopformba.com/wp-content/uploads/2021/04/country-main.png",
                        ),
                      ),
                      Center(
                        child: Text(
                          "Hello Guest User !!!",
                          style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                              fontFamily: 'Poppins-Black',
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: theme.colorScheme.onPrimary,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: theme.colorScheme.onPrimary,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: theme.colorScheme.onPrimary,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: theme.colorScheme.onPrimary,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Enter your name...",
                            hintStyle: TextStyle(
                              color: theme.colorScheme.onPrimary
                                  .withAlpha((255 * 0.5).toInt()),
                              fontFamily: 'Poppins-SemiBold',
                            ),
                            hintFadeDuration: Duration(milliseconds: 200),
                            counterText: "",
                            prefixIconColor: theme.colorScheme.onPrimary,
                            prefixIcon: Icon(Icons.account_circle_rounded),
                            suffixIcon: textController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        textController.clear();
                                      });
                                    },
                                    icon: Icon(Icons.close))
                                : null,
                            suffixIconColor: theme.colorScheme.onPrimary,
                          ),
                          cursorColor: theme.colorScheme.onPrimary,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontFamily: 'Poppins-SemiBold',
                          ),
                          cursorOpacityAnimates: true,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          onTapOutside: (_) => {
                            FocusScope.of(context).requestFocus(FocusNode())
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (_) {
                            setState(() {});
                          },
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) {
                            print("Ime Button Clicked");
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  theme.colorScheme.onPrimary),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 30.0),
                            child: Text(
                              "Next",
                              style:
                                  TextStyle(color: theme.colorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
