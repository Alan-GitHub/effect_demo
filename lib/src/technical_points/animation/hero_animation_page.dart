import 'package:flutter/material.dart';

class HeroAnimationPage extends StatelessWidget {
  const HeroAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    //timeDilation = 5.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          tag: "abc",
          photo: 'assets/images/1.jpeg',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Flippers Page'),
                    ),
                    body: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.topLeft,
                      child: PhotoHero(
                        tag: "abc",
                        photo: 'assets/images/2.jpeg',
                        width: 100.0,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.tag,
    required this.photo,
    required this.onTap,
    required this.width,
  });

  final String tag;
  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        child: Hero(
          tag: tag,
          child: Image.asset(
            photo,
            fit: BoxFit.contain,
          ),
        ),
      )
    );
  }
}
