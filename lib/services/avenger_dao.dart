import 'package:sembast/sembast.dart';

import '../models/avenger.dart';
import './app_database.dart';

class AvengerDao{
  static const String AVENGER_STORE_NAME = 'avengers';
  
  //A store with int keys & Map<String, dynamic> values
  //Store will act like persistent map, values of which are Avenger objects
  final _avengerStore = intMapStoreFactory.store(AVENGER_STORE_NAME);
  
  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;
  
  //INSERT
  Future insert(Avenger avenger) async{
    await _avengerStore.add(await _db, avenger.toMap());
  }
  
  //UPDATE
  Future update(Avenger avenger) async{
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(avenger.id));
    await _avengerStore.update(await _db, avenger.toMap(), finder: finder);
  }
  
  //DELETE
  Future delete(Avenger avenger) async{
    final finder = Finder(filter: Filter.byKey(avenger.id));
    await _avengerStore.delete(await _db, finder: finder);
  }

  //SELECT-SORTED
  Future<List<Avenger>> getAllBySortedNames() async{
    //finder object can aslo sort data
    final finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);
    
    //snapshot = item - that possess key & value
    final recordSnapShots = await _avengerStore.find(
      await _db,
      finder: finder,
    );
    
    //After converting List<snapshots> to our need i.e List<Avenger>, we will return
    return recordSnapShots.map((snapShot){
      final avenger = Avenger.fromMap(snapShot.value);
      // An ID is a key of a record from the database.
      avenger.id = snapShot.key;
      return avenger;
    }).toList();
  }
}