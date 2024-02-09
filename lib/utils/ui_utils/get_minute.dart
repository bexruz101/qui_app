String getMinutelyText(int timeInSeconds){
  int min = timeInSeconds ~/ 60;
  int sec = timeInSeconds % 60;
  String minute = min.toString().length <=1 ? "0$min":"$min";
  String second = sec.toString().length <=1 ? "0$sec":"$sec";

  return "$minute : $second";
}