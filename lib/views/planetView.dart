import 'dart:convert';

import 'package:astronomy_app/objects/planet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlanetView extends StatefulWidget {
  const PlanetView({Key? key, required this.id, required this.name})
      : super(key: key);
  final String id;
  final String name;
  @override
  State<StatefulWidget> createState() => _PlanetView();
}

class _PlanetView extends State<PlanetView> {
  Future<Planet?> informationPlanet() async {
    var data = await http.get(Uri.parse(
        'https://api.le-systeme-solaire.net/rest/bodies/${widget.id}'));
    if (data.statusCode == 200) {
      return Planet.fromJson(jsonDecode(data.body));
    }
  }

  @override
  void initState() {
    super.initState();
    informationPlanet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(children: [
        Hero(tag: widget.id,child:Image.asset('assets/img/${widget.id}.jpg')),
        FutureBuilder(
            future: informationPlanet(),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.done) {
                Planet? planet = data.data as Planet?;
                if (planet != null) {
                  return Column(children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 20),child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            Text('Moons'),
                            Text(planet.moons?.length.toString() ?? '0')
                          ]),
                          Column(children: [
                            Text('Density'),
                            Text(planet.density.toString())
                          ]),
                          Column(children: [
                            Text('Gravity'),
                            Text(planet.gravity.toString())
                          ])
                        ])),
                                            Padding(padding: EdgeInsets.symmetric(vertical: 20),child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            Text('Discovered By'),
                            Text(planet.discoveredBy.isEmpty ? 'NO Discovery yet' : planet.discoveredBy.replaceAll(',', '\n'))
                          ]),
                          Column(children: [
                            Text('Discovery Date'),
                            Text(planet.discoveryDate.isEmpty ? 'NO Discovery yet' : planet.discoveryDate)
                          ]),
                        ]))
                  ]);
                }
                return Text('No hay planeta');
              } else {
                return CircularProgressIndicator();
              }
            })
      ]),
    );
  }
}
