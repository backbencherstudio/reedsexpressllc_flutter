class TeamMemberModel {
  final String id;
  final String name;
  final bool isActive;
  final String carrier;
  final String state;
  final String contact;
  final String cdlNumber;
  final String registrationExpirationDate;
  final String cdlExpirationDate;
  final String medicalCardExpirationDate;

  const TeamMemberModel({
    required this.id,
    required this.name,
    this.isActive = true,
    required this.carrier,
    required this.state,
    required this.contact,
    required this.cdlNumber,
    required this.registrationExpirationDate,
    required this.cdlExpirationDate,
    required this.medicalCardExpirationDate,
  });
}
