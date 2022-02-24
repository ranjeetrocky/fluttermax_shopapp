class HttpExeption implements Exception {
  final message;
  HttpExeption(this.message);
  @override
  String toString() {
    // TODO: implement toString
    // return super.toString();//returns "Instance of HttpException"
    return "Exception: " + message;
  }
}
