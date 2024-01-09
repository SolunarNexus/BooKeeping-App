import 'package:rxdart/rxdart.dart';

class UserCardStateService {
  final _invitationSent = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get stream => _invitationSent.stream;

  void changeState(bool newState) {
    _invitationSent.add(newState);
  }
}
