enum RouteValue {
  splash(
    path: '/',
  ),
  home(
    path: '/home',
  ),
  addPond(
    path: 'addPond',
  ),
  details(
    path: 'details',
  ),
  tasks(
    path: 'tasks',
  ),
  history(
    path: 'history',
  ),
  choose(
    path: 'choose',
  ),
  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
