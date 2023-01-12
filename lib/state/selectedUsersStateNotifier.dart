// This will generates a Notifier and NotifierProvider.
// The Notifier class that will be passed to our NotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
// Finally, we are using selectedUserProvider(NotifierProvider) to allow the UI to
// interact with our Member class.
import 'package:dash/dtos/memberDto/memberDto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selectedUsersStateNotifier.g.dart';

@riverpod
class SelectedUsers extends _$SelectedUsers {
  @override
  List<Member> build() {
    return <Member>[];
  }

  // Let's allow the UI to add todos.
  void addUser(Member member) {
    // Since our state is immutable, we are not allowed to do `state.add(userId)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = [...state, member];
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  // Let's allow removing todos
  void removeUser(String userId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final member in state)
        if (member.uid != userId) member,
    ];
  }

  void clearUsers() {
    state = [];
  }
}