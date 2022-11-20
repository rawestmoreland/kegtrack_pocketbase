import 'package:pocketbase/pocketbase.dart';

class Keg extends RecordModel {
  final String name;
  final double remainingVolume;
  final double totalVolume;

  Keg({
    required this.name,
    required this.remainingVolume,
    required this.totalVolume,
  });

  factory Keg.fromJson(Map<String, dynamic> json) {
    return Keg(
      name: json['name'],
      remainingVolume: (json['remaining_volume'] ?? 0.0).toDouble(),
      totalVolume: (json['total_volume'] ?? 0.0).toDouble(),
    );
  }

  @override
  Map<String, Object> toJson() => {
        'name': name,
        'remaining_volume': remainingVolume,
        'total_volume': totalVolume,
      };
}
