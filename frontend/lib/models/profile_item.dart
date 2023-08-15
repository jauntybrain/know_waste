class ProfileItem {
  const ProfileItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.routeName,
    this.registeredOnly = false,
    this.hasChevron = true,
  });

  final String icon;
  final String title;
  final String subtitle;
  final String routeName;
  final bool registeredOnly;
  final bool hasChevron;
}
