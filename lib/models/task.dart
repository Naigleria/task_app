import 'dart:typed_data';

class Tarea {
  int? id;
  String titulo;
  String descripcion;
  String fechaCreacion;
  String estatus;
  String fechaTermino;
  String imagen;

  Tarea({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaCreacion,
    required this.estatus,
    required this.fechaTermino,
    required this.imagen,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha_creacion': fechaCreacion,
      'estatus': estatus,
      'fecha_termino': fechaTermino,
      'imagen': imagen,
    };
  }

  static Tarea fromMap(Map<String, dynamic> map) {
    return Tarea(
      id: map['id'],
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      fechaCreacion: map['fecha_creacion'],
      estatus: map['estatus'],
      fechaTermino: map['fecha_termino'],
      imagen: map['imagen'],
    );
  }
}
