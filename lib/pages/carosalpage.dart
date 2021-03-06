import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:toppers_pakistan/models/carosel_model.dart';
import 'package:toppers_pakistan/services/carosel_service.dart';

import '../simple-future-builder.dart';

class Carosal extends StatefulWidget {
  @override
  _CarosalState createState() => _CarosalState();
}

class _CarosalState extends State<Carosal> {
  final _caroselService = CaroselService();

  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder.simpler(
          future: _caroselService.fetchAll(),
          context: context,
          builder: (AsyncSnapshot<List<CaroselModel>> snapshot) {
            return CarouselSlider(
              height: 200.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 5),
              scrollDirection: Axis.horizontal,
              items: snapshot.data.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Image.network(
                        "http://nabeel-pc:8000/images/carosel/" + imgUrl.image,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            );
          })
    ;
  }
}
