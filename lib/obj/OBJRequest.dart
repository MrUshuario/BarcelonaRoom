class Request<T> {
  String? message;
  T? data; //CLAVE FORANEA
  String? error;
  


  Request({
    this.message,
    this.data,
    this.error,
    required T,
  });

  factory Request.fromJson(dynamic json)  => Request(
    message: json['codigoRequest'] as String?,
    T: json['data'], //Map<String, dynamic> data = jsonDecode(response.body);
    error: json['numero'] as String?,

  );

  static List<Request> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Request> items =
    bienvenidaList.map((e) => Request.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "message": data,
      "data":T,
      "error":error,
    };
  }
  
}