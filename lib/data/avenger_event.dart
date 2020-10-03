import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/avenger.dart';

@immutable
abstract class AvengerEvent extends Equatable{
  AvengerEvent([List props = const []]): super(props);
}

class LoadAvengers extends AvengerEvent{}

class AddRandomAvenger extends AvengerEvent{}

class UpdateWithRandomAvanger extends AvengerEvent{
  final Avenger updatedAvenger;

  UpdateWithRandomAvanger(this.updatedAvenger): super([updatedAvenger]);
}

class DeleteAvenger extends AvengerEvent{
  final Avenger avenger;

  DeleteAvenger(this.avenger): super([avenger]);
}


