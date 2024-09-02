import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class ImageZoomPage extends StatelessWidget {
  const ImageZoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 140,
              child: InstaImageViewer(
                child: Image(
                  image: Image.network("https://picsum.photos/id/429/1080/1920")
                      .image,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 100,
              height: 140,
              child: InstaImageViewer(
                child: Image(
                  image:
                      Image.network("https://picsum.photos/id/507/1000").image,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
