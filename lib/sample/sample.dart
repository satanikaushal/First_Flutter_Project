import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Center(
            child: Container(
              height: 220,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.solid,
                    blurRadius: 5
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(
                    "https://img.freepik.com/free-vector/digital-glowing-technology-lines-with-metwork-wire-mesh_1017-28404.jpg",
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.8
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Image.network(
                          "https://cdn.freebiesupply.com/logos/large/2x/visa-logo-png-transparent.png",
                          width: 100,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "7894 1257 4589 6258",
                              style: GoogleFonts.sourceCodePro(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 22,
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                letterSpacing:0.1,
                              ),
                            ),
                            SizedBox(height: 3,),
                            Text(
                              "Ankit Musk".toUpperCase(),
                              style: GoogleFonts.sourceCodePro(
                                  color: Colors.grey.shade400,
                                  fontSize: 18,
                                  // fontStyle: FontStyle.italic,
                                letterSpacing: 1
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  Positioned(
                    top: 5,
                    right: 15,
                    child: Image.asset(
                      "assets/images/chip.png",
                      width: 75,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
