import 'package:book_keeping/common/service/converter_service.dart';
import 'package:book_keeping/common/service/library_search_state_service.dart';
import 'package:book_keeping/common/service/search_friend_state_service.dart';
import 'package:book_keeping/common/service/search_rating_state_service.dart';
import 'package:book_keeping/common/service/user_card_state_service.dart';
import 'package:book_keeping/data_access/facade/book_facade.dart';
import 'package:book_keeping/data_access/facade/book_rating_facade.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/data_access/facade/my_book_facade.dart';
import 'package:book_keeping/data_access/facade/recommendation_facade.dart';
import 'package:book_keeping/data_access/facade/user_facade.dart';
import 'package:book_keeping/data_access/service/book_rating_service.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:book_keeping/data_access/service/friendship_service.dart';
import 'package:book_keeping/data_access/service/my_book_service.dart';
import 'package:book_keeping/data_access/service/recommendation_service.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:book_keeping/web_api/service/open_library_service.dart';
import 'package:get_it/get_it.dart';

import '../service/add_friend_state_service.dart';
import '../service/search_mybook_state_service.dart';

class IocContainer {
  static void setup() {
    var getIt = GetIt.instance;
    getIt.registerSingleton(BookService());
    getIt.registerSingleton(UserService());
    getIt.registerSingleton(MyBookService());
    getIt.registerSingleton(BookRatingService());
    getIt.registerSingleton(FriendshipService());
    getIt.registerSingleton(RecommendationService());

    getIt.registerSingleton(ConverterService());

    getIt.registerSingleton(OpenLibraryService());

    getIt.registerSingleton(MyBookFacade());
    getIt.registerSingleton(RecommendationFacade());
    getIt.registerSingleton(BookFacade());
    getIt.registerSingleton(UserFacade());
    getIt.registerSingleton(BookRatingFacade());
    getIt.registerSingleton(FriendshipFacade());

    getIt.registerSingleton(AddFriendStateService());
    getIt.registerSingleton(SearchFriendStateService());
    getIt.registerSingleton(SearchMyBookStateService());
    getIt.registerFactory(
      () => UserCardStateService(),
    );
    getIt.registerSingleton(SearchRatingStateService());
    getIt.registerSingleton(LibrarySearchStateService());
  }
}
