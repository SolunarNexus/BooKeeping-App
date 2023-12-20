import 'package:book_keeping/common/service/converter_service.dart';
import 'package:book_keeping/data_access/facade/my_book_facade.dart';
import 'package:book_keeping/data_access/facade/recommendation_facade.dart';
import 'package:book_keeping/data_access/service/book_rating_service.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:book_keeping/data_access/service/friend_request_service.dart';
import 'package:book_keeping/data_access/service/friend_service.dart';
import 'package:book_keeping/data_access/service/my_book_service.dart';
import 'package:book_keeping/data_access/service/recommendation_service.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:get_it/get_it.dart';

class IocContainer {
  static void setup() {
    var getIt = GetIt.instance;
    getIt.registerSingleton(BookService());
    getIt.registerSingleton(UserService());
    getIt.registerSingleton(MyBookService());
    getIt.registerSingleton(BookRatingService());
    getIt.registerSingleton(FriendService());
    getIt.registerSingleton(FriendRequestService());
    getIt.registerSingleton(RecommendationService());
    getIt.registerSingleton(ConverterService());
    getIt.registerSingleton(MyBookFacade());
    getIt.registerSingleton(RecommendationFacade());
  }
}
