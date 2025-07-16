import 'package:secretbox/shared/data/remote/network_service.dart';
import 'package:secretbox/shared/domain/models/core/either.dart';
import 'package:secretbox/shared/domain/models/setting.dart';
import 'package:secretbox/shared/domain/models/voucher.dart';
import 'package:secretbox/shared/exceptions/http_exception.dart';

abstract class GameDataSource {
  Future<Either<AppException, Setting>> getSetting();
  Future<Either<AppException, Voucher>> getVoucher(String code);
  Future<Either<AppException, bool>> openPrize(String code);
}

class GameRemoteDataSource implements GameDataSource {
  final NetworkService networkService;

  GameRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, Setting>> getSetting() async {
    final response = await networkService.get('game/');

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'fetchGame',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }

      return Right(Setting.fromJson(jsonData));
    });
  }

  @override
  Future<Either<AppException, Voucher>> getVoucher(String code) async {
    final body = {'code': code};
    final response = await networkService.post('check/', data: body);

    return response.fold(
      (l) {
        return Left(
          AppException(
            identifier: 'fetchVoucher',
            statusCode: 0,
            message: 'Voucher tidak valid',
          ),
        );
      },
      (r) {
        final jsonData = r.data;
        if (jsonData == null) {
          return Left(
            AppException(
              identifier: 'fetchVoucher',
              statusCode: 0,
              message: 'Voucher tidak valid',
            ),
          );
        }

        return Right(Voucher.fromJson(jsonData));
      },
    );
  }
  
  @override
  Future<Either<AppException, bool>> openPrize(String code) async {
    final body = {'code': code};
    final response = await networkService.post('open/', data: body);

    return response.fold(
      (l) {
        return Left(
          AppException(
            identifier: 'fetchVoucher',
            statusCode: 0,
            message: 'Voucher tidak valid',
          ),
        );
      },
      (r) {
        final jsonData = r.data;
        if (jsonData == null) {
          return Left(
            AppException(
              identifier: 'fetchVoucher',
              statusCode: 0,
              message: 'Voucher tidak valid',
            ),
          );
        }

        return Right(true);
      },
    );
  }
}
