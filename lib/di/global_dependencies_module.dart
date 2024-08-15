 
import 'package:gandalverse/data/shared_preferences/shared_preferences_client.dart';
import 'package:injectable/injectable.dart' hide Environment; 

@module
abstract class GlobalDependenciesModule {
  @preResolve
  Future<SharedPreferencesClient> get sharedPreferenceClient =>
      SharedPreferencesClient.init();

  // @preResolve
  // Future<Configuration> get configuration => Configuration.init();

  // @preResolve
  // Future<FirebaseClient> get firebaseClient => FirebaseClient.init(); 
 
}