import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/avenger.dart';

@immutable
abstract class AvengerState extends Equatable{
  AvengerState([List props = const []]): super(props);
}

class AvengerLoading extends AvengerState{}

class AvengerLoaded extends AvengerState{
  final List<Avenger> avengers;

  AvengerLoaded(this.avengers): super([avengers]);
}