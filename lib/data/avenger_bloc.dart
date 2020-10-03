import 'dart:async';

import 'package:bloc/bloc.dart';

import '../models/avenger.dart';
import '../services/avenger_dao.dart';
import './bloc.dart';

class AvengerBloc extends Bloc<AvengerEvent, AvengerState>{
  AvengerDao _avengerDao = AvengerDao();

  //Display loading indicator right from the start of the app
  @override
  AvengerState get initialState => AvengerLoading();

  @override
  Stream<AvengerState> mapEventToState(AvengerEvent event) async* {
    if(event is LoadAvengers){
      //Indicating that fruits are being loaded - display progress indicator.
      yield AvengerLoading();
      yield* _reloadAvengers();
    }else if(event is AddRandomAvenger){
      // Loading indicator shouldn't be displayed while adding/updating/deleting
      // a single Avenger from the database - we aren't yielding AvengerLoading().
      await _avengerDao.insert(RandomAvengerGenerator.getRandomAvenger());
      yield* _reloadAvengers();
    }else if(event is UpdateWithRandomAvanger){
      final newAvenger = RandomAvengerGenerator.getRandomAvenger();

      //keeping the ID of the avenger same
      newAvenger.id = event.updatedAvenger.id;
      //Update avenger
      await _avengerDao.update(newAvenger);
      yield* _reloadAvengers();
    }else if(event is DeleteAvenger){
      await _avengerDao.delete(event.avenger);
      yield* _reloadAvengers();
    }
  }
  
  //Get/Read latest avengers data from persistent data storage (SEMBAST)
  Stream<AvengerState> _reloadAvengers() async* {
    final avengers = await _avengerDao.getAllBySortedNames();

    yield AvengerLoaded(avengers);
  }
}

