/// Functions

String buildStringWithNewlines(dynamic stringList) {
  if(stringList.runtimeType == String) return stringList;
  return stringList.join('\n');
}