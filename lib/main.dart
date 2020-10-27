import 'package:ProyectoAnalisis2/features/user/presentation/bloc/sharedata/share_data_bloc.dart';
import 'package:ProyectoAnalisis2/features/user/presentation/bloc/userbloc/user_bloc.dart';
import 'package:ProyectoAnalisis2/features/user/presentation/pages/user_home_page.dart';
import 'package:ProyectoAnalisis2/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<UserBloc>(),
        ),
        BlocProvider(
          create: (_) => ShareDataBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserHomePage(),
      ),
    );
  }
}
