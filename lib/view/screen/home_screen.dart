import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://th.bing.com/th/id/R.916e699b606fe1368fcde3316cd4661e?rik=kQQtgHOUAgKGlw&riu=http%3a%2f%2fgetwallpapers.com%2fwallpaper%2ffull%2f1%2f9%2fc%2f432258.jpg&ehk=P5TLyd21rtR%2ffnXKiDT65eTzF2ylPEISNAT2CyRpZOo%3d&risl=&pid=ImgRaw&r=0'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: height / 4,
                  width: width,
                  // color: Colors.red,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'NAME',
                      style: GoogleFonts.ubuntuCondensed(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: width,
                    // color: Colors.blue,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: width / 5,
                        height: height / 10,
                        child: GestureDetector(
                          onTap: () {
                            log('ontapppppppppppppppppppppppppp');
                          },
                          child: Center(
                            child: Text(
                              'continue with google',
                              style: GoogleFonts.ubuntuCondensed(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
