import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ProyectoAnalisis2/features/user/presentation/bloc/userbloc/user_bloc.dart';
import 'package:ProyectoAnalisis2/features/user/presentation/pages/widgets/layout_home_page.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proyecto ADS2 Grupo1'),
        actions: [
          IconButton(
              icon: Icon(Icons.people),
              onPressed: () {
                BlocProvider.of<UserBloc>(context).add(GetUserForRandom());
              })
        ],
      ),
      body: LayoutHomePage(),
    );
  }
}
