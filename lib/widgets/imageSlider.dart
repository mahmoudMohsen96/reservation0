import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
class ImageSlider extends StatelessWidget {
  final deviceSize;
  final List img;
  ImageSlider(this.deviceSize,this.img);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    height: deviceSize.height * .35,
                    width: deviceSize.width,
                    child: Carousel(boxFit: BoxFit.cover,
                      images: [
                        ...img.map((f){
                          return NetworkImage(f);
                        }).toList()
                      ],
                      overlayShadow: false,
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.bottomLeft,dotSize: 6,dotSpacing: 13,dotIncreaseSize: 1.7,
                    ),
                  )
                 ;
  }
}