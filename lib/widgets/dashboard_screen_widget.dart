import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreenWidget extends StatefulWidget {
  const DashboardScreenWidget({super.key});

  @override
  State<DashboardScreenWidget> createState() => _DashboardScreenWidgetState();
}

class _DashboardScreenWidgetState extends State<DashboardScreenWidget> {

  var tilesList = [
    ["assets/images/ic_manage_address.png", "Manage Address"],
    ["assets/images/ic_completed_orders.png", "Completed Order"],
    ["assets/images/ic_incomplete_orders.png", "Pending Orders"],
    ["assets/images/ic_privacy_policy.png", "Privacy Policy"],
    ["assets/images/ic_terms_conditions.png", "Terms & Conditions"],
    ["assets/images/ic_delete_account.png", "Delete Account"],
    ["assets/images/ic_call_drawer.png", "Contact Us"],
    ["assets/images/ic_logout_account.png", "Logout"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: GoogleFonts.poppins(
                  color: Colors.green.shade700,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3),
            ),
            Text(
              "Har Roz Naariyal Pani Aapke Ghar",
              style: GoogleFonts.poppins(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.4),
            ),
          ],
        ),
        titleSpacing: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.green.shade700,
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                // cross icon
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton.outlined(
                    style: ButtonStyle(
                        side: WidgetStatePropertyAll(BorderSide(
                            color: Colors.lightGreen.shade800, width: 1.5)),
                        iconColor:
                        WidgetStatePropertyAll(Colors.lightGreen.shade800),
                        foregroundColor:
                        WidgetStatePropertyAll(Colors.lightGreen.shade800)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close),
                    alignment: Alignment.center,
                    iconSize: 25,
                    constraints: BoxConstraints(maxWidth: 35),
                    padding: EdgeInsets.all(3),
                  ),
                ),
                // avatar and names

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.lightGreen.shade800,
                      radius: 38,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kaushal Satani",
                          style: GoogleFonts.poppins(
                              color: Colors.lightGreen.shade800,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        Text("+91 9408400274",
                            style: GoogleFonts.poppins(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                                fontSize: 14))
                      ],
                    )
                  ],
                ),

                SizedBox(height: 13,),
                Divider(
                  // height: 1,
                  color: Colors.grey.shade400,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tilesList.length, // Number of items in the list
                    itemBuilder: (context, index) {
                      final item = tilesList[index];
                      return ListTile(
                        leading: Image.asset(item[0], height: 25, width: 25,),
                        title: Text(
                            item[1],
                          style: GoogleFonts.poppins(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                          ),
                        ),
                        minVerticalPadding: 0,
                        minTileHeight: 52,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawerEdgeDragWidth: MediaQuery
          .of(context)
          .size
          .width,
      // drawerEnableOpenDragGesture: true,
      // endDrawerEnableOpenDragGesture: true,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Image.asset("assets/images/ic_coconut_main.png"),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 170,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    WidgetStatePropertyAll(Colors.lightGreen.shade800),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {},
                child: Text(
                  "Order Now",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
