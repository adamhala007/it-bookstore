import 'package:dio/dio.dart';
import 'package:it_bookstore/app/constant.dart';
import 'package:it_bookstore/data/responses/responses.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET("/search/{query}")
  Future<BookStoreResponse> search(
    @Path("query") String query,
  );

  @GET("/search/{query}/{page}")
  Future<BookStoreResponse> paginatedSearch(
    @Path("query") String query,
    @Path("page") int page,
  );

  @GET("/new")
  Future<BookStoreResponse> searchNewReleases();

  @GET("/books/{isbn13}")
  Future<BookResponse> getBookDetail(
    @Path("isbn13") String isbn13,
  );
}
