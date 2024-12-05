enum IconProvider {
  splash(imageName: 'splash.png'),
  catalog(imageName: 'catalog.svg'),
  home(imageName: 'home.svg'),
  diary(imageName: 'diary.svg'),
  greenBall(imageName: 'green_ball.png'),
  redBall(imageName: 'red_ball.png'),
  yellowBall(imageName: 'yellow_ball.png'),
  greyBall(imageName: 'grey_ball.png'),
  logo(imageName: 'logo.png'),
  background(imageName: 'background.png'),
  unknown(imageName: '');

  const IconProvider({
    required this.imageName,
  });

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
