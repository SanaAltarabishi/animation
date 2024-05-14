import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:google_fonts/google_fonts.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 450,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:[ Colors.yellow.shade200, Colors.purple.shade100 ]),
       
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SwiperBuilder(),
        ],
      ),
    );
  }
}

class SwiperBuilder extends StatelessWidget {
  const SwiperBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Swiper(
              itemWidth: 400,
              itemHeight: 225,
              loop: true,
              duration: 1200,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Huppy',
                          style: GoogleFonts.annieUseYourTelescope(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'M',
                              style: GoogleFonts.annieUseYourTelescope(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Colors.black),
                            ),
                            Icon(
                              Icons.favorite_border,
                              size: 35,
                              color: Colors.black,
                              weight: 50,
                            ),
                            Text(
                              "ther's Day",
                              style: GoogleFonts.annieUseYourTelescope(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else if (index == 1) {
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'My MUM',
                          style: GoogleFonts.annieUseYourTelescope(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'MY QUEEN',
                          style: GoogleFonts.annieUseYourTelescope(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.black),
                        )
                      ],
                    ),
                  );
                } else if (index == 2) {
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dear Mom',
                          style: GoogleFonts.annieUseYourTelescope(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'you are my best friend',
                          style: GoogleFonts.annieUseYourTelescope(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: 3,
              layout: SwiperLayout.STACK,
            ),
          ),
        ),
      ),
    );
  }
}
