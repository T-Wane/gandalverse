// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gandalverse/core/providers/user_provider.dart' as _i5;
import 'package:gandalverse/core/repositories/user_repository.dart' as _i4;
import 'package:gandalverse/data/shared_preferences/shared_preferences_client.dart'
    as _i3;
import 'package:gandalverse/di/global_dependencies_module.dart' as _i6;
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
    gh.lazySingleton<_i4.UserRepository>(() => _i4.UserRepository());
    gh.singleton<_i5.UserProvider>(
        () => _i5.UserProvider(gh<_i4.UserRepository>()));
    return this;
  }
}

class _$GlobalDependenciesModule extends _i6.GlobalDependenciesModule {}
