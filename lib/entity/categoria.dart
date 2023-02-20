class Categoria {
  int? id;
  String nome;

  Categoria({this.id, required this.nome});

  getId() {
    return id;
  }

  void setId(id) {
    this.id = id;
  }
}
