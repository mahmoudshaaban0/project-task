enum AppRoutes {
  splash('/', 'splash'),
  home('/home', 'home'),
  payments('/payments', 'payments'),
  // Top level (not inside the tab shell) so it covers the tab bar and can be
  // opened from Home and Payments alike; back returns to the opening tab.
  paymentDetails('/payment/:id', 'payment_details');

  const AppRoutes(this.path, this.name);
  final String path;
  final String name;
}
