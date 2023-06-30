import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picasso/cubit/search_result_cubit.dart';
import 'screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchResultCubit>(create: (_) => SearchResultCubit())
      ],
      child: MaterialApp(
        title: 'Picasso',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const LandingScreen(),
      ),
    );
  }
}
