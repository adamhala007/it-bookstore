import 'package:get_it/get_it.dart';
import 'package:it_bookstore/data/data_source/remote_data_soruce.dart';
import 'package:it_bookstore/data/network/app_api.dart';
import 'package:it_bookstore/data/network/dio_factory.dart';
import 'package:it_bookstore/data/repository/repository_impl.dart';
import 'package:it_bookstore/domain/repository/repository.dart';
import 'package:it_bookstore/domain/usecase/load_book_details_usecase.dart';
import 'package:it_bookstore/domain/usecase/new_releases_usecase.dart';
import 'package:it_bookstore/domain/usecase/paginated_search_usecase.dart';
import 'package:it_bookstore/domain/usecase/search_usecase.dart';
import 'package:it_bookstore/presentation/book_details/book_details_viewmodel.dart';
import 'package:it_bookstore/presentation/books/books_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance()));
}

initBookStoreModule() {
  if (!GetIt.I.isRegistered<NewReleaseUseCase>()) {
    instance.registerFactory<NewReleaseUseCase>(
        () => NewReleaseUseCase(instance()));
    instance.registerFactory<SearchUseCase>(() => SearchUseCase(instance()));
    instance.registerFactory<PaginatedSearchUseCase>(
        () => PaginatedSearchUseCase(instance()));
    instance.registerFactory<BooksViewModel>(
        () => BooksViewModel(instance(), instance(), instance()));
  }
}

initBookDetailModule() {
  if (!GetIt.I.isRegistered<LoadBookDetailsUseCase>()) {
    instance.registerFactory<LoadBookDetailsUseCase>(
        () => LoadBookDetailsUseCase(instance()));
    instance.registerFactory<BookDetailsViewModel>(
        () => BookDetailsViewModel(instance()));
  }
}
