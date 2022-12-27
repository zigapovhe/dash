import 'package:dash/dtos/memberDto/memberDto.dart';
import 'package:dash/helpers/constants.dart';
import 'package:dash/services/localStorageService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider<LocalStorage>((ref){
  return LocalStorage();
});

final getUserFromStorageProvider = FutureProvider((ref) async {
  final localStorage = ref.read(localStorageProvider);
  final userObject = await localStorage.loadString(key: Constants.userObjectKey);
  return Member.fromJson(userObject as Map<String, dynamic>);
});

