// lib/app/data/models/load_details_model.dart

import 'dart:ui';

import '../../core/constants/enums.dart';

enum TrackingStatus { assigned, pickup, delivered, completed }

class TrackingStepModel {
  final String title;
  final String dateTime;
  final TrackingStatus status;
  final bool isDone;
  final bool isActive;
  final String? subNote;

  const TrackingStepModel({
    required this.title,
    required this.dateTime,
    required this.status,
    this.isDone = false,
    this.isActive = false,
    this.subNote,
  });
}

class UploadedDocumentModel {
  final String fileName;
  final String fileSize;
  final String uploadedAt;
  final String tag;
  final Color tagColor;

  const UploadedDocumentModel({
    required this.fileName,
    required this.fileSize,
    required this.uploadedAt,
    required this.tag,
    required this.tagColor,
  });
}

class LoadDetailsModel {
  final String loadId;
  final String date;
  final LoadStatus status;
  final int miles;
  final double pay;

  // Pickup
  final String pickupCompany;
  final String pickupAddress;
  final String pickupTime;
  final String pickupDate;

  // Delivery
  final String deliveryCompany;
  final String deliveryAddress;
  final String deliveryTime;
  final String deliveryDate;

  // Broker
  final String brokerName;
  final String brokerReference;
  final String brokerEmail;
  final String brokerPhone;

  final String additionalNotes;
  final List<TrackingStepModel> trackingSteps;
  final List<UploadedDocumentModel> uploadedDocuments;

  const LoadDetailsModel({
    required this.loadId,
    required this.date,
    required this.status,
    required this.miles,
    required this.pay,
    required this.pickupCompany,
    required this.pickupAddress,
    required this.pickupTime,
    required this.pickupDate,
    required this.deliveryCompany,
    required this.deliveryAddress,
    required this.deliveryTime,
    required this.deliveryDate,
    required this.brokerName,
    required this.brokerReference,
    required this.brokerEmail,
    required this.brokerPhone,
    required this.additionalNotes,
    required this.trackingSteps,
    required this.uploadedDocuments,
  });
}