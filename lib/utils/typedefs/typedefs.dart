import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/sky_architecture.dart';

typedef OtpSentCallback =
    void Function(String verificationId, int? forceResendingToken);

typedef VerificationFailedCallback = void Function(String message);

typedef FutureEitherFailure<T> = Future<Either<Failure, T>>;

typedef FutureEitherFailureUnit = FutureEitherFailure<Unit>;
