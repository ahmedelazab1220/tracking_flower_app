import 'package:injectable/injectable.dart';

import '../../../domain/auth/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {}
