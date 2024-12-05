enum RouteValue {
  splash(
    path: '/',
  ),
  home(
    path: '/home',
  ),
  catalog(
    path: '/catalog',
  ),
  diary(
    path: '/diary',
  ),
  info(
    path: 'info',
  ),
  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
