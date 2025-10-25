import 'package:birthmark/core/di/injector.dart';
import 'package:birthmark/features/birthdate/presentation/pages/birthdate_page.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: const BirthDatePage(),
    );
  }
}
