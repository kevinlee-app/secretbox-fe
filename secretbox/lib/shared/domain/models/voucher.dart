import 'package:secretbox/shared/domain/models/prize.dart';

class Voucher {
  final String code;
  final Prize prize;

  Voucher({
    required this.code,
    required this.prize,
  });
}