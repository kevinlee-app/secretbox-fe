import 'package:secretbox/shared/data/remote/network_service.dart';
import 'package:secretbox/shared/domain/models/asset.dart';
import 'package:secretbox/shared/domain/models/company.dart';
import 'package:secretbox/shared/domain/models/core/either.dart';
import 'package:secretbox/shared/domain/models/prize.dart';
import 'package:secretbox/shared/domain/models/setting.dart';
import 'package:secretbox/shared/domain/models/voucher.dart';
import 'package:secretbox/shared/domain/models/wording.dart';
import 'package:secretbox/shared/exceptions/http_exception.dart';

abstract class GameDataSource {
  Future<Either<AppException, Setting>> getSetting();
  Future<Either<AppException, Voucher>> getVoucher(String code);
}

class GameRemoteDataSource implements GameDataSource {
  final NetworkService networkService;

  GameRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, Setting>> getSetting() async {
    await Future.delayed(const Duration(seconds: 1));

    return Right(
      Setting(
        company: Company(name: 'Awesome Co', logoUrl: 'url', id: '1'),
        prizes: [
          Prize(name: 'Car', id: '1', imageUrl: 'url'),
          Prize(name: 'Phone 2', id: '2', imageUrl: 'url'),
          Prize(name: 'Phone 3', id: '3', imageUrl: 'url'),
          Prize(name: 'Phone 4', id: '4', imageUrl: 'url'),
          Prize(name: 'Phone 5', id: '5', imageUrl: 'url'),
          Prize(name: 'Phone 6', id: '6', imageUrl: 'url'),
          Prize(name: 'Phone 7', id: '7', imageUrl: 'url'),
          Prize(name: 'Phone 8', id: '8', imageUrl: 'url'),
          Prize(name: 'Phone 9', id: '9', imageUrl: 'url'),
          Prize(name: 'Phone 10', id: '10', imageUrl: 'url'),
        ],
        wording: Wording(
          welcomeText: "Welcome to the game!",
          spinningText: "Spinning...",
          choosePrizeText: "Choose your prize!",
          winningText: "Congratulation! You win {{PRIZE}}",
        ),
        maxSelectablePrizes: 1,
        asset: Asset(
          backgroundImageUrl:
              'https://fastly.picsum.photos/id/424/1920/1080.jpg?hmac=JzwsjH5Hrdi5_3bo5flu2W0XaDry_ZmPotU9x0KEja4',
          boxClosedUrl: '',
          boxOpenedUrl: '',
        ),
      ),
    );
  }

  @override
  Future<Either<AppException, Voucher>> getVoucher(String code) async {
    await Future.delayed(const Duration(seconds: 1));

    return Right(
      Voucher(
        code: "ABKLJLJKSALD",
        prize: Prize(name: 'Car', id: '1', imageUrl: 'url'),
      ),
    );
  }
}
