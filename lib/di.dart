import 'package:bein_ecommerce/core/shared_pref/app_prefs.dart';
import 'package:bein_ecommerce/features/cart/data/data_source/cash_data_source/cartId_cash_data_source.dart';
import 'package:bein_ecommerce/features/cart/data/data_source/remote_data_source/cart_remote_data_source.dart';
import 'package:bein_ecommerce/features/cart/data/repositories/cart_repo_impl.dart';
import 'package:bein_ecommerce/features/cart/domain/repositories/cart_repo.dart';
import 'package:bein_ecommerce/features/cart/domain/use_cases/cart_use_case.dart';
import 'package:bein_ecommerce/features/home/categories/data/data_sources/all_category_remote_dataSource.dart';
import 'package:bein_ecommerce/features/home/categories/data/repositories/category_repo_impl.dart';
import 'package:bein_ecommerce/features/home/categories/domain/repositories/category_repo.dart';
import 'package:bein_ecommerce/features/home/categories/domain/use_cases/get_all_category.dart';
import 'package:bein_ecommerce/features/home/categories/presentation/manager/category_cubit.dart';
import 'package:bein_ecommerce/features/home/products/data/data_sources/remote_data_source/all_products_remote_data_source.dart';
import 'package:bein_ecommerce/features/home/products/data/repositories/products_repo_impl.dart';
import 'package:bein_ecommerce/features/home/products/domain/repositories/products_repo.dart';
import 'package:bein_ecommerce/features/home/products/domain/use_cases/get_all_products.dart';
import 'package:bein_ecommerce/features/home/products/presentation/manager/product_cubit.dart';
import 'package:bein_ecommerce/features/on_boarding/data/data_sources/countries_cache_data_source.dart';
import 'package:bein_ecommerce/features/on_boarding/data/data_sources/getCountries.dart';
import 'package:bein_ecommerce/features/on_boarding/data/repositories/country_repo_impl.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/repositories/countries_repo.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/use_cases/get_all_countries.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/use_cases/get_current_country_usecase.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/use_cases/save_country_selection_usecase.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/manager/countries_cubit.dart';
import 'package:bein_ecommerce/features/orders/data/my_orders_remote_data_source.dart';
import 'package:bein_ecommerce/features/orders/data/repositories/myOrders_repo_impl.dart';
import 'package:bein_ecommerce/features/orders/domain/use_cases/my_orders_use_case.dart';
import 'package:bein_ecommerce/features/orders/presentation/manager/myOrders_cubit.dart';
import 'package:bein_ecommerce/features/splash/data/repository/lang_repository_impl.dart';
import 'package:bein_ecommerce/features/splash/data/source/locale_lang/lang_locale_data_source.dart';
import 'package:bein_ecommerce/features/splash/domain/repository/local/lang_repository.dart';
import 'package:bein_ecommerce/features/splash/domain/usecases/local_use_case/change_local_lang.dart';
import 'package:bein_ecommerce/features/splash/domain/usecases/local_use_case/get_saved_lang.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/data_sources/cashe_data_source/login_cashe_data_source.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/data_sources/remote_data_source/login_remote_data_source.dart';
import 'package:bein_ecommerce/features/user/auth/login/domain/repositories/login_repo.dart';
import 'package:bein_ecommerce/features/user/auth/login/domain/use_cases/login_use_case.dart';
import 'package:bein_ecommerce/features/user/profile/data/local/data_sources/user_profile_remote_data_source.dart';
import 'package:bein_ecommerce/features/user/profile/data/repositories/profile_repo_impl.dart';
import 'package:bein_ecommerce/features/user/profile/domain/repositories/profile_repo.dart';
import 'package:bein_ecommerce/features/user/profile/domain/use_cases/profile_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/network_checker/network_checker.dart';
import 'features/cart/presentation/manager/cart_cubit.dart';
import 'features/orders/domain/repositories/my_orders_repo.dart';
import 'features/splash/presentation/localization/local_bloc/local_cubit.dart';
import 'features/user/auth/login/data/repositories/login_repo_impl.dart';
import 'features/user/auth/login/presentation/manager/login_cubit.dart';
import 'features/user/profile/presentation/manager/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Blocs
  sl.registerFactory<LocaleCubit>(
      () => LocaleCubit(changeLangUseCase: sl(), getSavedLangUseCase: sl()));

  sl.registerFactory<CountriesCubit>(() => CountriesCubit(
        getCurrentCountryUseCase: sl<GetCurrentCountryUseCase>(),
        saveCountrySelectionUseCase: sl<SaveCountrySelectionUseCase>(),
        getAllCountriesUseCase: sl<GetAllCountriesUseCase>(),
      ));

  sl.registerFactory<ProductCubit>(() => ProductCubit(
        getAllProductsUseCase: sl<GetAllProductsUseCase>(),
      ));
  sl.registerFactory<CategoryCubit>(() => CategoryCubit(
        getAllCategoryUseCase: sl<GetAllCategoryUseCase>(),
      ));

  sl.registerFactory<CartCubit>(() => CartCubit(
        cartUseCase: sl<CartUseCase>(),
      ));
  sl.registerFactory<LoginCubit>(() => LoginCubit(
        loginUseCase: sl<LoginUseCase>(),
      ));
  sl.registerFactory<MyOrdersCubit>(() => MyOrdersCubit(
        myOrdersUseCase: sl<MyOrdersUseCase>(),
      ));
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(
        profileUseCase: sl<ProfileUseCase>(),
      ));
  //use-cases
  sl.registerLazySingleton<GetCurrentCountryUseCase>(
      () => GetCurrentCountryUseCase(countriesRepo: sl()));
  sl.registerLazySingleton<SaveCountrySelectionUseCase>(
      () => SaveCountrySelectionUseCase(countriesRepo: sl()));
  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<GetAllCountriesUseCase>(
      () => GetAllCountriesUseCase(countriesRepo: sl()));
  sl.registerLazySingleton<GetAllProductsUseCase>(
      () => GetAllProductsUseCase(productRepo: sl()));
  sl.registerLazySingleton<GetAllCategoryUseCase>(
      () => GetAllCategoryUseCase(categoryRepo: sl()));
  sl.registerLazySingleton<CartUseCase>(() => CartUseCase(cartRepo: sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(loginRepo: sl()));
  sl.registerLazySingleton<MyOrdersUseCase>(
      () => MyOrdersUseCase(myOrdersRepo: sl()));

  sl.registerLazySingleton<ProfileUseCase>(
      () => ProfileUseCase(profileRepo: sl()));

  //repositories
  sl.registerLazySingleton<LangRepository>(
      () => LangRepositoryImpl(langLocalDataSource: sl()));
  sl.registerLazySingleton<CountriesRepo>(() => CountryRepoImpl(
      countriesCacheDataSource: sl<CountriesCacheDataSource>(),
      networkInfo: sl(),
      countriesRemoteDataSource: sl()));
  sl.registerLazySingleton<ProductsRepo>(() => ProductsRepoImpl(
        allProductsRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(
        allCategoryRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<CartRepo>(() => CartRepoImpl(
      cartRemoteDataSource: sl(),
      networkInfo: sl(),
      cartCacheDataSource: sl<CartCacheDataSource>()));
  sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(
      networkInfo: sl(),
      loginRemoteDataSource: sl(),
      loginCasheDataSource: sl<LoginCasheDataSource>()));
  sl.registerLazySingleton<MyOrdersRepo>(() => MyOrdersRepoImpl(
        networkInfo: sl(),
        myOrdersRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(
        networkInfo: sl(),
        profileRemoteDataSource: sl(),
      ));

  //DataSource
  sl.registerLazySingleton<LangLocalDataSource>(() =>
      LangLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()));
  sl.registerLazySingleton<CountriesCacheDataSource>(() =>
      CountriesCacheDataSourceImpl(sharedPreferences: sl<SharedPreferences>()));
  sl.registerLazySingleton<CountriesRemoteDataSource>(
      () => CountriesRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<AllProductsRemoteDataSource>(
      () => AllProductsRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<AllCategoryRemoteDataSource>(
      () => AllCategoryRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<CartCacheDataSource>(() =>
      CartCacheDataSourceImpl(sharedPreferences: sl<SharedPreferences>()));
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<LoginCasheDataSource>(() =>
      LoginCasheDataSourceImpl(sharedPreferences: sl<SharedPreferences>()));
  sl.registerLazySingleton<MyOrdersRemoteDataSource>(
      () => MyOrdersRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(apiConsumer: sl()));

  //extract
  sl.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sl<SharedPreferences>()));
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
