

class ImageUtil{
  static String getImgPath(String name, {String format: 'png'}){
    return 'images/$name.$format';
  }

}