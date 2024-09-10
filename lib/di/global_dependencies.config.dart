// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gandalverse/core/providers/charge_provider.dart' as _i7;
import 'package:gandalverse/core/providers/user_provider.dart' as _i11;
import 'package:gandalverse/core/repositories/dailyRewardRepository.dart'
    as _i12;
import 'package:gandalverse/core/repositories/social_link_repo/social_linkRespository.dart'
    as _i8;
import 'package:gandalverse/core/repositories/tabAndEarnRepository.dart'
    as _i13;
import 'package:gandalverse/core/repositories/user_repository.dart' as _i10;
import 'package:gandalverse/core/services/explorer_service/explorer_service.dart'
    as _i9;
import 'package:gandalverse/core/services/QG_services/equipe_service.dart'
    as _i14;
import 'package:gandalverse/core/services/QG_services/partenaire_service.dart'
    as _i15;
import 'package:gandalverse/data/firebase_client.dart' as _i6;
import 'package:gandalverse/data/shared_preferences/shared_preferences_client.dart'
    as _i3;
import 'package:gandalverse/data/telegram_client.dart' as _i5;
import 'package:gandalverse/data/tg_storage/telegram_cloudStorage.dart' as _i4;
import 'package:gandalverse/di/global_dependencies_module.dart' as _i16;
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
    await gh.factoryAsync<_i5.TelegramClient>(
      () => globalDependenciesModule.telegramClient,
      preResolve: true,
    );
    await gh.factoryAsync<_i6.FirebaseClient>(
      () => globalDependenciesModule.firebaseClient,
      preResolve: true,
    );
    gh.singleton<_i7.ChargeManager>(() => _i7.ChargeManager());
    gh.singleton<_i8.SocialLinkService>(() => _i8.SocialLinkService());
    gh.singleton<_i9.ExplorerService>(() => _i9.ExplorerService());
    gh.lazySingleton<_i10.UserRepository>(
        () => _i10.UserRepository(gh<_i4.TelegramCloudStorage>()));
    gh.singleton<_i11.UserProvider>(() => _i11.UserProvider(
          gh<_i5.TelegramClient>(),
          gh<_i10.UserRepository>(),
        ));
    gh.singleton<_i12.DailyRewardManager>(
        () => _i12.DailyRewardManager(gh<_i11.UserProvider>()));
    gh.singleton<_i13.TapAndEarnRepository>(
        () => _i13.TapAndEarnRepository(gh<_i11.UserProvider>()));
    gh.lazySingleton<_i14.EquipeService>(
        () => _i14.EquipeService(gh<_i11.UserProvider>()));
    gh.lazySingleton<_i15.PartenaireService>(
        () => _i15.PartenaireService(gh<_i11.UserProvider>()));
    return this;
  }
}

class _$GlobalDependenciesModule extends _i16.GlobalDependenciesModule {}
