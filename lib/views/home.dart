import 'dart:convert';

import 'package:astronomy_app/objects/planet.dart';
import 'package:astronomy_app/views/planetView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  List<Planet> planets = [];
  int _focusedIndex = 0;
  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  Future<void> getPlanets() async {
    var data = await http.get(Uri.parse(
        'https://api.le-systeme-solaire.net/rest/bodies?filter[]=isPlanet,eq,true'));
    if (data.statusCode == 200) {
      var body = jsonDecode(data.body);
      List<Planet> newPlanets = (body['bodies'] as List)
          .map((value) => Planet.fromJson(value))
          .toList();
      setState(() {
        planets = newPlanets;
      });
      print(body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlanets();
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 3) * 2;
    return Scaffold(
      body: ScrollSnapList(
        onItemFocus: _onItemFocus,
        itemSize: width,
        itemBuilder: (c, index) => Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),child:GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> PlanetView(id: planets[index].id, name: planets[index].englishName,)));
            },
            child: Column(children: [
              Expanded(
                  child: Column(children: [
                Text(
                  planets[index].englishName,
                  style: Theme.of(context).textTheme.headline1,
                )
              ])),
              Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  width: width,
                  child: Column(
                    children: [
                      Hero(tag: planets[index].id,child:Image.asset('assets/img/${planets[index].id}.jpg')),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  )),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [])),
            ]))),
        itemCount: planets.length,
        scrollDirection: Axis.horizontal,
        dynamicItemSize: true,
      ),
    );
  }
}
