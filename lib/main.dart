import 'package:birthmark/core/di/injector.dart';
import 'package:birthmark/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:birthmark/features/auth/presentation/bloc/auth_event.dart';
import 'package:birthmark/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<AuthBloc>()..add(CheckAuthEvent()),
      child: const CupertinoApp(
        home: AuthPage(),
      ),
    );
  }
}