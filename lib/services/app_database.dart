import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase{

  //a private constructor. allows you to create instances of AppDatabse only from clas itself
  AppDatabase._();

  //singleton instance
  static final AppDatabase _singleton = AppDatabase._();

  //singleton accessor
  static AppDatabase get instance => _singleton;

  //completor is used for transforming synchronous code to asynchronous code
  Completer<Database> _dbOpenCompleter;

  // Sembast database object
  Database _database;
  
  //database object accessor
  Future<Database> get database async{
    //if completor is null, AppDatabase class is newly instantiated, so Database is not open yet
    if(_dbOpenCompleter == null){
      _dbOpenCompleter = new Completer();
      //calling _openDatabase will also complete the completer with database instance
      _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter.future;
  }
  
  //Open Database
  Future _openDatabase()async{
    //get a platform-specific directory where persistent app-data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();

    //path pattern:- /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'demo.db');
    
    //open database
    final database = databaseFactoryIo.openDatabase(dbPath);

    //any code awaiting the Completor's future will now start executing
    _dbOpenCompleter.complete(database);  // signaling the completor instance that now you can go ahead without waiting
  }



}