class Produtos {
  final int? id;
  final String nome; // nome do produto
  final String local; // onde será encontrado o produto
  final String comentarios; // comentários sobre o produto

  Produtos({
    this.id,
    required this.nome,
    required this.local,
    required this.comentarios,
  });

  Map<String, dynamic> toJson() => {
        '_id': id,
        'nome': nome,
        'origem': local,
        'comentarios': comentarios,
      };

  factory Produtos.fromJson(Map<String, dynamic> json) {
    return Produtos(
      id: json['_id'],
      nome: json['nome'],
      local: json['local'],
      comentarios: json['comentarios'],
    );
  }
}
