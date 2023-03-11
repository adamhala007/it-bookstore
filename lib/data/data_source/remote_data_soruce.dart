import 'package:it_bookstore/data/network/app_api.dart';
import 'package:it_bookstore/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<BookStoreResponse> search(String query);
  Future<BookStoreResponse> paginatedSearch(String query, int page);
  Future<BookStoreResponse> searchNewReleases();
  Future<BookResponse> getBookDetail(String isbn13);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BookResponse> getBookDetail(String isbn13) async {
    return await _appServiceClient.getBookDetail(isbn13);
  }

  @override
  Future<BookStoreResponse> paginatedSearch(String query, int page) async {
    return await _appServiceClient.paginatedSearch(query, page);
  }

  @override
  Future<BookStoreResponse> search(String query) async {
    return await _appServiceClient.search(query);
  }

  @override
  Future<BookStoreResponse> searchNewReleases() async {
    return await _appServiceClient.searchNewReleases();
  }
}
