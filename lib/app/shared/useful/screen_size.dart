class ScreenSize {
  final double height;
  final double width;

  ScreenSize({required this.height, required this.width});

  bool resolutionMaxMin() {
    return width > 600.0 ? true : false;
  }

  int resolutionScren() {
    if (width < 319.0)
      return 1; //smartphones
    else if (width > 319.0 && width <= 599.0)
      return 2; //smartphones
    else if (width > 600.0 && width < 800.0)
      return 3; //Tablets
    else if (width > 800.0 && width < 1280.0)
      return 4; //landscape monitors
    else
      return 5; //portrait monitors
  }

  bool isHeigthImg() {
    return height < 600.0;
  }

  bool isDeskLandscape() {
    return width > 1280.0;
  }

  bool isDeskPortrait() {
    return width > 800.0 && width < 1280.0;
  }

  bool isTablet() {
    return width > 600.0 && width < 800.0;
  }

  bool isMobile() {
    return width > 319.0 && width <= 599.0;
  }

  double totalWidth() {
    return width;
  }

  double totalHeight() {
    return height;
  }

  double column_1() {
    final result = 8.33 / 100 * width;
    return result;
  }

  double column_2() {
    final result = 16.66 / 100 * width;
    return result;
  }

  double column_3() {
    final result = 25 / 100 * width;
    return result;
  }

  double column_4() {
    final result = 33.33 / 100 * width;
    return result;
  }

  double column_5() {
    final result = 41.66 / 100 * width;
    return result;
  }

  double column_6() {
    final result = 50 / 100 * width;
    return result;
  }

  double column_7() {
    final result = 58.33 / 100 * width;
    return result;
  }

  double column_8() {
    final result = 66.66 / 100 * width;
    return result;
  }

  double column_9() {
    final result = 75 / 100 * width;
    return result;
  }

  double column_10() {
    final result = 83.33 / 100 * width;
    return result;
  }

  double column_11() {
    final result = 91.66 / 100 * width;
    return result;
  }

  double column_12() {
    final result = 100 * width;
    return result;
  }
}
