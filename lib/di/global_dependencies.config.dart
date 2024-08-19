// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gandalverse/core/providers/charge_provider.dart' as _i7;
import 'package:gandalverse/core/providers/user_provider.dart' as _i9;
import 'package:gandalverse/core/repositories/tabAndEarnRepository.dart'
    as _i10;
import 'package:gandalverse/core/repositories/user_repository.dart' as _i8;
import 'package:gandalverse/core/services/QG_services/equipe_service.dart'
    as _i11;
import 'package:gandalverse/core/services/QG_services/partenaire_service.dart'
    as _i12;
import 'package:gandalverse/data/firebase_client.dart' as _i5;
import 'package:gandalverse/data/shared_preferences/shared_preferences_client.dart'
    as _i3;
import 'package:gandalverse/data/telegram_client.dart' as _i6;
import 'package:gandalverse/data/tg_storage/telegram_cloudStorage.dart' as _i4;
import 'package:gandalverse/di/global_dependencies_module.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final globalDependenciesModule = _$GlobalDependenciesModule();
    await gh.factoryAsync<_i3.SharedPreferencesClient>(
      () => globalDependenciesModule.sharedPreferenceClient,
      preResolve: true,
    );
    await gh.factoryAsync<_i4.TelegramCloudStorage>(
      () => globalDependenciesModule.telegramStorage,
      preResolve: true,
    );
    await gh.factoryAsync<_i5.FirebaseClient>(
      () => globalDependenciesModule.firebaseClient,
      preResolve: true,
    );
    await gh.factoryAsync<_i6.TelegramClient>(
      () => globalDependenciesModule.telegramClient,
      preResolve: true,
    );
    gh.singleton<_i7.ChargeManager>(() => _i7.ChargeManager());
    gh.lazySingleton<_i8.UserRepository>(
        () => _i8.UserRepository(gh<_i4.TelegramCloudStorage>()));
    gh.singleton<_i9.UserProvider>(() => _i9.UserProvider(
          gh<_i6.TelegramClient>(),
          gh<_i8.UserRepository>(),
        ));
    gh.singleton<_i10.TapAndEarnRepository>(
        () => _i10.TapAndEarnRepository(gh<_i9.UserProvider>()));
    gh.lazySingleton<_i11.EquipeService>(
        () => _i11.EquipeService(gh<_i9.UserProvider>()));
    gh.lazySingleton<_i12.PartenaireService>(
        () => _i12.PartenaireService(gh<_i9.UserProvider>()));
    return this;
  }
}

class _$GlobalDependenciesModule extends _i13.GlobalDependenciesModule {}
