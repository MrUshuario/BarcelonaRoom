
class respFormato {
  String? coMensaje;
  String? descMensaje;

  respFormato.fromJson(dynamic json) {
    coMensaje = json['coMensaje'];
    descMensaje = json['deMensaje'];
  }

  respFormato({this.coMensaje, this.descMensaje});
}
