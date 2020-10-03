import 'dart:math';

import 'package:meta/meta.dart';

class Avenger {
  int id;

  final String name;
  final bool isHero;

  Avenger({
    @required this.name,
    @required this.isHero,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isHero': isHero,
    };
  }

  static Avenger fromMap(Map<String, dynamic> map) {
    return Avenger(
      name: map['name'],
      isHero: map['isHero'],
    );
  }
}

class RandomAvengerGenerator {
  static final _avengers = [
    Avenger(name: 'Iron Man', isHero: true),
    Avenger(name: 'Captain America', isHero: true),
    Avenger(name: 'Thanos', isHero: false),
    Avenger(name: 'Black Widow', isHero: true),
    Avenger(name: 'Spider Man', isHero: true),
    Avenger(name: 'Deadpool', isHero: false),
    Avenger(name: 'Black Panther', isHero: true),
    Avenger(name: 'Loki', isHero: false),
    Avenger(name: 'Thor', isHero: true),
  ];

  static Avenger getRandomAvenger() {
    return _avengers[Random().nextInt(_avengers.length)];
  }
}
