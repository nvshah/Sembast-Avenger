import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/avenger.dart';
import '../data/bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AvengerBloc _avengerBloc;

  @override
  void initState() {
    super.initState();
    // Obtaining the FruitBloc instance through BlocProvider which is an InheritedWidget
    _avengerBloc = BlocProvider.of<AvengerBloc>(context);
    // Events can be passed into the bloc by calling dispatch.
    // We want to start loading fruits right from the start.
    _avengerBloc.dispatch(LoadAvengers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel SuperStar'),
      ),
      body: _buildBody(),
    );
  }
  
  ///Build the body for Page
  Widget _buildBody() {
    return BlocBuilder(
      bloc: _avengerBloc,
      // Whenever there is a new state emitted from the bloc, builder runs.
      builder: (BuildContext ctxt, AvengerState state) {
        if (state is AvengerLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AvengerLoaded) {
          //* Note here you will get state as Casted object of type AvengerLoaded i.e (AvengerLoaded)state
          //* & so you will be able to access AvengerLoaded property over here on state object without casting
          //* it to AvengerLoaded object explicitly
          //final s = state as AvengerLoaded;   //Unnecssary Cast
          return _buildListView(state);
        }else{
          return Center(
            child: Text('Something Went Wrong !... Gonna catch later'),
          );
        }
      },
    );
  }
  
  ///Build list of Avengers
  Widget _buildListView(AvengerLoaded state) {
    return ListView.builder(
      itemCount: state.avengers.length,
      //here ctxt will be passed bu flutter not use we need to just define method as per signature
      itemBuilder: (ctxt, index) {
        //get the avenger
        final displayedAvenger = state.avengers[index];
        return ListTile(
          title: Text(displayedAvenger.name),
          subtitle: Text(displayedAvenger.isHero ? 'Team-IM!' : 'Team-CA!'),
          trailing: _buildUpdateDeletedButtons(displayedAvenger),
        );
      },
    );
  }
  
  ///Build buttons for update & delete
  Widget _buildUpdateDeletedButtons(Avenger avenger) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        //UPDATE
        IconButton(
          icon: Icon(Icons.update),
          onPressed: () =>
              _avengerBloc.dispatch(UpdateWithRandomAvenger(avenger)),
        ),
        //DELETE
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _avengerBloc.dispatch(DeleteAvenger(avenger)),
        ),
      ],
    );
  }
}
