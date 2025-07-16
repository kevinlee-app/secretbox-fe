import 'package:secretbox/shared/domain/models/asset.dart';
import 'package:secretbox/shared/domain/models/audio.dart';

import 'company.dart';
import 'prize.dart';
import 'wording.dart';

class Setting {
  final Asset asset;
  final Company company;
  final List<Prize> prizes;
  final Wording wording;
  final Audio audio;

  Setting({
    required this.asset,
    required this.company,
    required this.prizes,
    required this.wording,
    required this.audio,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      asset: Asset.fromJson(json['asset']),
      company: Company.fromJson(json['company']),
      prizes:
          (json['prizes'] as List<dynamic>)
              .map((e) => Prize.fromJson(e))
              .toList(),
      wording: Wording.fromJson(json['wording']),
      audio: Audio.fromJson(json['audio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asset': asset.toJson(),
      'company': company.toJson(),
      'prizes': prizes.map((e) => e.toJson()).toList(),
      'wording': wording.toJson(),
      'audio': audio.toJson(),
    };
  }
}
