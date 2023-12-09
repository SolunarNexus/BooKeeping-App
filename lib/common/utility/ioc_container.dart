import 'package:book_keeping/common/service/open_library_service.dart';
import 'package:get_it/get_it.dart';

class IocContainer {
  static void setup() {
    var getIt = GetIt.instance;
    getIt.registerSingleton(OpenLibraryService());
  }
}
