class NotificationDto {
  NotificationDto({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.screen,
    required this.parameter,
    required this.redirectUrl,
    required this.createDate,
  });

  final int id;
  final String title;
  final String body;
  final bool isRead;
  final String screen;
  final String parameter;
  final String redirectUrl;
  final String createDate;
}
