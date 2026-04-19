// lib/app/data/models/load_model.dart

import '../../core/constants/enums.dart';

class LoadModel {
  final String loadId;
  final String? date;
  final String originCity;
  final String originAddress;
  final String originTime;
  final String destinationCity;
  final String destinationAddress;
  final int miles;
  final double pay;
  final LoadStatus status;

  const LoadModel({
    required this.loadId,
    this.date,
    required this.originCity,
    required this.originAddress,
    required this.originTime,
    required this.destinationCity,
    required this.destinationAddress,
    required this.miles,
    required this.pay,
    required this.status,
  });
}
