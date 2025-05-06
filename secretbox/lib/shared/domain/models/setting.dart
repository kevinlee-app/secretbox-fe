import 'package:secretbox/shared/domain/models/asset.dart';

import 'company.dart';
import 'prize.dart';
import 'wording.dart';

class Setting {
  final int maxSelectablePrizes;
  final Asset asset;
  final Company company;
  final List<Prize> prizes;
  final Wording wording;

  Setting({
    required this.maxSelectablePrizes,
    required this.asset,
    required this.company,
    required this.prizes,
    required this.wording,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      maxSelectablePrizes: json['max_selectable_prizes'] as int,
      asset: Asset.fromJson(json['asset']),
      company: Company.fromJson(json['company']),
      prizes:
          (json['prizes'] as List<dynamic>)
              .map((e) => Prize.fromJson(e))
              .toList(),
      wording: Wording.fromJson(json['wording']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max_selectable_prizes': maxSelectablePrizes,
      'asset': asset.toJson(),
      'company': company.toJson(),
      'prizes': prizes.map((e) => e.toJson()).toList(),
      'wording': wording.toJson(),
    };
  }
}
