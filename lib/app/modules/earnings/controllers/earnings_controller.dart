import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoadBreakdown {
  final String id;
  final String route;
  final String distance;
  final double amount;

  LoadBreakdown({
    required this.id,
    required this.route,
    required this.distance,
    required this.amount,
  });
}

class EarningsController extends GetxController {
  final searchController = TextEditingController();
  
  final startDate = Rxn<DateTime>();
  final endDate = Rxn<DateTime>();
  
  final loadCompleted = 3.obs;
  final milesDriven = 247.obs;
  final totalEarnings = 10200.00.obs;

  final loadBreakdowns = <LoadBreakdown>[
    LoadBreakdown(
      id: 'LD-2024-001',
      route: 'Dallas, TX → Chicago, IL',
      distance: '62 mi',
      amount: 4200.00,
    ),
    LoadBreakdown(
      id: 'LD-2024-001',
      route: 'Dallas, TX → Chicago, IL',
      distance: '62 mi',
      amount: 4200.00,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    final dateFormat = DateFormat('dd/MM/yyyy');
    startDate.value = dateFormat.parse('06/05/2025');
    endDate.value = dateFormat.parse('13/05/2025');
  }

  String get dateRangeText {
    if (startDate.value == null || endDate.value == null) return 'Select Date Range';
    final dateFormat = DateFormat('dd/MM/yyyy');
    return '${dateFormat.format(startDate.value!)} - ${dateFormat.format(endDate.value!)}';
  }
}
