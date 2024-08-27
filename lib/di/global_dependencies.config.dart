// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gandalverse/core/providers/charge_provider.dart' as _i114;
import 'package:gandalverse/core/providers/user_provider.dart' as _i977;
import 'package:gandalverse/core/repositories/tabAndEarnRepository.dart'
    as _i556;
import 'package:gandalverse/core/repositories/user_repository.dart' as _i658;
import 'package:gandalverse/core/services/QG_services/equipe_service.dart'
    as _i962;
import 'package:gandalverse/core/services/QG_services/partenaire_service.dart'
    as _i809;
import 'package:gandalverse/data/firebase_client.dart' as _i185;
import 'package:gandalverse/data/shared_preferences/shared_preferences_client.dart'
    as _i419;
import 'package:gandalverse/data/tg_storage/telegram_cloudStorage.dart'
    as _i1039;
import 'package:gandalverse/di/global_dependencies_module.dart' as _i425;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final globalDependenciesModule = _$GlobalDependenciesModule();
    await gh.factoryAsync<_i419.SharedPreferencesClient>(
      () => globalDependenciesModule.sharedPreferenceClient,
      preResolve: true,
    );
    await gh.factoryAsync<_i1039.TelegramCloudStorage>(
      () => globalDependenciesModule.telegramStorage,
      preResolve: true,
    );
    await gh.factoryAsync<_i185.FirebaseClient>(
      () => globalDependenciesModule.firebaseClient,
      preResolve: true,
    );
    gh.singleton<_i114.ChargeManager>(() => _i114.ChargeManager());
    gh.lazySingleton<_i658.UserRepository>(
        () => _i658.UserRepository(gh<_i1039.TelegramCloudStorage>()));
    gh.singleton<_i977.UserProvider>(
        () => _i977.UserProvider(gh<_i658.UserRepository>()));
    gh.singleton<_i556.TapAndEarnRepository>(
        () => _i556.TapAndEarnRepository(gh<_i977.UserProvider>()));
    gh.lazySingleton<_i962.EquipeService>(
        () => _i962.EquipeService(gh<_i977.UserProvider>()));
    gh.lazySingleton<_i809.PartenaireService>(
        () => _i809.PartenaireService(gh<_i977.UserProvider>()));
    return this;
  }
}

class _$GlobalDependenciesModule extends _i425.GlobalDependenciesModule {}
