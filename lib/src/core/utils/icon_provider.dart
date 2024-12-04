enum IconProvider {
  alert(imageName: 'alert.png'),
  error(imageName: 'error.png'),
  fish(imageName: 'fish.png'),
  logo(imageName: 'logo.png'),
  splash(imageName: 'splash.png'),
  decor(imageName: 'decor.png'),
  appBar(imageName: 'appbar.png'),
  noPhoto(imageName: "no_photo.png"),
  back(imageName: 'back.png'),
  photo(imageName: 'photo.png'),
  add(imageName: 'add.png'),
  masqot1(imageName: 'masqot1.webp'),
  masqot2(imageName: 'masqot2.webp'),
  masqot3(imageName: 'masqot3.webp'),
  masqot4(imageName: 'masqot4.webp'),
  unknown(imageName: '');

  const IconProvider({
    required this.imageName,
  });

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
