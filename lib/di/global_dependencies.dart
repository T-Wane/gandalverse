import "package:gandalverse/di/global_dependencies.config.dart";
import "package:get_it/get_it.dart";
import "package:injectable/injectable.dart"; 
final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies() async => getIt.init();
