import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_snkrs_clone/app.dart';
import 'package:nike_snkrs_clone/app_bloc_observer.dart';
import 'package:nike_snkrs_clone/features/authentication/authentication_repository_impl.dart';
import 'package:nike_snkrs_clone/features/authentication/bloc/authentication_bloc.dart';
import 'package:nike_snkrs_clone/features/database/bloc/database_bloc.dart';
import 'package:nike_snkrs_clone/features/database/database_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(AuthenticationRepositoryImpl())
                ..add(AuthenticationStarted()),
        ),
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
        )
      ],
      child: const App(),
    ),
  );
}

class SNKRS extends StatefulWidget {
  const SNKRS({super.key});

  @override
  State<SNKRS> createState() => _SNKRSState();
}

class _SNKRSState extends State<SNKRS> {
  int _currentIndex = 0;

  void _onTappedItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTappedItem,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey.shade400,
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outlined),
            label: "Mail",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
