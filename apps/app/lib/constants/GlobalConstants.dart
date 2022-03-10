String host = "http://10.0.2.2:8000/";

enum OrderStatus {
  pending,
  inprogress,
  ready,
}

class ResponseDTO {
  String message;
  int statusCode;

  ResponseDTO({required this.message, required this.statusCode});
}
