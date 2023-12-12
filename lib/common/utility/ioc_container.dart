import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:get_it/get_it.dart';

class IocContainer {
  static void setup() {
    var getIt = GetIt.instance;
    getIt.registerSingleton(BookService());
    getIt.registerSingleton(UserService());
  }
}
