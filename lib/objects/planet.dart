class Planet {
  String id;
  String name;
  String englishName;
  bool isPLanet;
  List<dynamic>? moons;
  int 	semimajorAxis;
  int perihelion;
  int 	aphelion;
  double eccentricity;
  double inclination;
  Map<String, dynamic>? vol;
  double density;
  double gravity;
  double escape;
  String dimension;
  String discoveredBy;
  String discoveryDate;
  int avgTemp;
  String bodyType;

  Planet({
    required this.id,
    required this.name,
    required this.englishName,
    required this.isPLanet,
    required this.moons,
    required this.semimajorAxis,
    required this.perihelion,
    required this.aphelion,
    required this.eccentricity,
    required this.inclination,
    required this.vol,
    required this.density,
    required this.gravity,
    required this.escape,
    required this.dimension,
    required this.discoveredBy,
    required this.discoveryDate,
    required this.avgTemp,
    required this.bodyType,
  });

  Planet.fromJson(Map<String, dynamic>json)
  : id = json['id'],
  name = json['name'],
  englishName = json['englishName'],
  isPLanet = json['isPlanet'] as bool,
  moons = json['moons'],
  semimajorAxis = json['semimajorAxis'],
  perihelion = json['perihelion'],
  aphelion = json['aphelion'],
  eccentricity = json['eccentricity'],
  inclination = json['inclination'] is int ? (json['inclination'] as int).toDouble() :json['inclination'],
  vol = json['vol'],
  density = json['density'],
  gravity = json['gravity'],
  escape = json['escape'],
  dimension = json['dimension'],
  discoveredBy = json['discoveredBy'],
  discoveryDate = json['discoveryDate'],
  avgTemp = json['avgTemp'],
  bodyType = json['bodyType'];

}