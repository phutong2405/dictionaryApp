import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/data_in_cubit.dart';
import 'package:dictionary_app_1110/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => AppBloc(),
          ),
          BlocProvider(
            create: (context) => FavoriteCubit(),
          ),
        ], child: const MainView()));
  }
}

// BlocProvider(
//             create: (context) => AppBloc(), child: const MainView()));

// MultiBlocProvider(providers: [
//           BlocProvider(
//             create: (context) => AppBloc(),
//           ),
//           BlocProvider(
//             create: (context) => HistoryCubit(),
//           ),
//         ], child: const MainView()));