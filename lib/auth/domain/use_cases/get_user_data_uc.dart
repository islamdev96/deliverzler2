import 'package:deliverzler/auth/data/repos/auth_repo.dart';
import 'package:deliverzler/auth/domain/entities/user.dart';
import 'package:deliverzler/auth/domain/repos/i_auth_repo.dart';
import 'package:deliverzler/core/domain/use_cases/use_case_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_user_data_uc.g.dart';

@Riverpod(keepAlive: true)
GetUserDataUC getUserDataUC(GetUserDataUCRef ref) {
  return GetUserDataUC(
    authRepo: ref.watch(authRepoProvider),
  );
}

class GetUserDataUC implements UseCaseBase<User, String> {
  GetUserDataUC({required this.authRepo});

  final IAuthRepo authRepo;

  @override
  Future<User> call(String uid) async {
    return await authRepo.getUserData(uid);
  }
}
