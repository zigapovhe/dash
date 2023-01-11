
// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
import 'package:dash/dtos/memberDto/memberDto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberNotifier extends StateNotifier<Member?> {
  MemberNotifier() : super(null);

  void newMember(Member member) {
    state = member;
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  void updateName({required String name}){
    state = state!.copyWith(name: name);
  }

  void clearMember(){
    state = null;
  }
}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our MemberNotifier class.
final memberProvider = StateNotifierProvider<MemberNotifier, Member?>((ref) {
  return MemberNotifier();
});