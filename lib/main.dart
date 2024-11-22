import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
        ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade900),
      ).copyWith(
          textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: Theme
                  .of(context)
                  .colorScheme
                  .onPrimary,
              selectionColor: Theme
                  .of(context)
                  .colorScheme
                  .secondary)),
      home: MyHomePage(),
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
            Expanded(child: Center(
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
                          onTapOutside: (_) =>
                          {FocusScope.of(context).requestFocus(FocusNode())},
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                              backgroundColor:
                              WidgetStateProperty.all(theme.colorScheme.onPrimary),
                              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 30.0),
                            child: Text(
                              "Next",
                              style: TextStyle(color: theme.colorScheme.primary),
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
        )
    );
  }
}
