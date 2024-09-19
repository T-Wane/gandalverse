// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gandalverse/core/providers/charge_provider.dart' as _i7;
import 'package:gandalverse/core/providers/player_provider.dart' as _i11;
import 'package:gandalverse/core/providers/user_provider.dart' as _i12;
import 'package:gandalverse/core/repositories/dailyRewardRepository.dart'
    as _i14;
import 'package:gandalverse/core/repositories/myProfitRepository.dart' as _i15;
import 'package:gandalverse/core/repositories/playersRepository.dart' as _i9;
import 'package:gandalverse/core/repositories/social_link_repo/social_linkRespository.dart'
    as _i13;
import 'package:gandalverse/core/repositories/spinRewardRepository.dart'
    as _i16;
import 'package:gandalverse/core/repositories/tabAndEarnRepository.dart'
    as _i17;
import 'package:gandalverse/core/repositories/user_repository.dart' as _i10;
import 'package:gandalverse/core/services/explorer_service/explorer_service.dart'
    as _i8;
import 'package:gandalverse/core/services/QG_services/equipe_service.dart'
    as _i18;
import 'package:gandalverse/core/services/QG_services/partenaire_service.dart'
    as _i19;
import 'package:gandalverse/data/firebase_client.dart' as _i6;
import 'package:gandalverse/data/shared_preferences/shared_preferences_client.dart'
    as _i3;
import 'package:gandalverse/data/telegram_client.dart' as _i5;
import 'package:gandalverse/data/tg_storage/telegram_cloudStorage.dart' as _i4;
import 'package:gandalverse/di/global_dependencies_module.dart' as _i20;
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
    gh.singleton<_i8.ExplorerService>(() => _i8.ExplorerService());
    gh.lazySingleton<_i9.PlayerRepository>(
        () => _i9.PlayerRepository(gh<_i4.TelegramCloudStorage>()));
    gh.lazySingleton<_i10.UserRepository>(
        () => _i10.UserRepository(gh<_i4.TelegramCloudStorage>()));
    gh.singleton<_i11.PlayerProvider>(
        () => _i11.PlayerProvider(gh<_i9.PlayerRepository>()));
    gh.singleton<_i12.UserProvider>(() => _i12.UserProvider(
          gh<_i5.TelegramClient>(),
          gh<_i10.UserRepository>(),
        ));
    gh.singleton<_i13.SocialLinkService>(
        () => _i13.SocialLinkService(gh<_i12.UserProvider>()));
    gh.singleton<_i14.DailyRewardManager>(
        () => _i14.DailyRewardManager(gh<_i12.UserProvider>()));
    gh.singleton<_i15.MyProfitManager>(
        () => _i15.MyProfitManager(gh<_i12.UserProvider>()));
    gh.singleton<_i16.SpinRewardManager>(
        () => _i16.SpinRewardManager(gh<_i12.UserProvider>()));
    gh.singleton<_i17.TapAndEarnRepository>(
        () => _i17.TapAndEarnRepository(gh<_i12.UserProvider>()));
    gh.lazySingleton<_i18.EquipeService>(
        () => _i18.EquipeService(gh<_i12.UserProvider>()));
    gh.lazySingleton<_i19.PartenaireService>(
        () => _i19.PartenaireService(gh<_i12.UserProvider>()));
    return this;
  }
}

class _$GlobalDependenciesModule extends _i20.GlobalDependenciesModule {}
