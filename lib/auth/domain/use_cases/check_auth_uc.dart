import 'package:deliverzler/auth/data/repos/auth_repo.dart';
import 'package:deliverzler/auth/domain/entities/user.dart';
import 'package:deliverzler/auth/domain/repos/i_auth_repo.dart';
import 'package:deliverzler/auth/domain/use_cases/get_user_data_uc.dart';
import 'package:deliverzler/auth/domain/use_cases/sign_out_uc.dart';
import 'package:deliverzler/core/domain/use_cases/use_case_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_auth_uc.g.dart';

@Riverpod(keepAlive: true)
CheckAuthUC checkAuthUC(CheckAuthUCRef ref) {
  return CheckAuthUC(
    ref,
    authRepo: ref.watch(authRepoProvider),
  );
}

class CheckAuthUC implements UseCaseNoParamsBase<User> {
  CheckAuthUC(this.ref, {required this.authRepo});

  final CheckAuthUCRef ref;
  final IAuthRepo authRepo;

  @override
  Future<User> call() async {
    final uid = await authRepo.getUserAuthUid();
    return await getUserData(uid);
  }

  Future<User> getUserData(String uid) async {
    try {
      final user = await ref.read(getUserDataUCProvider).call(uid);
      return user;
    } catch (err) {
      await ref.read(signOutUCProvider).call();
      rethrow;
    }
  }
}
