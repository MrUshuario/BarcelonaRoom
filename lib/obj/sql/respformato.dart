
class ApiRequestEstudiante {
  String? coMensaje;
  String? descMensaje;

  ApiRequestEstudiante.fromJson(dynamic json) {
    coMensaje = json['coMensaje'];
    descMensaje = json['deMensaje'];
  }

  ApiRequestEstudiante({this.coMensaje, this.descMensaje});
}
