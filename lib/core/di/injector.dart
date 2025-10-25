import 'package:birthmark/core/di/injector.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt injector = GetIt.instance;

@InjectableInit()
Future<GetIt> configureDependencies() async => await injector.init();