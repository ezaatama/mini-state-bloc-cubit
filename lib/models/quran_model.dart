import 'package:equatable/equatable.dart';

class Quran extends Equatable {
  Quran({
    this.arti,
    this.asma,
    this.ayat,
    this.nama,
    this.type,
    this.urut,
    this.audio,
    this.nomor,
    this.rukuk,
    this.keterangan,
  });

  String? arti;
  String? asma;
  int? ayat;
  String? nama;
  String? type;
  String? urut;
  String? audio;
  String? nomor;
  String? rukuk;
  String? keterangan;

  factory Quran.fromJson(Map<String, dynamic> json) => Quran(
        arti: json["arti"],
        asma: json["asma"],
        ayat: json["ayat"],
        nama: json["nama"],
        type: json["type"],
        urut: json["urut"],
        audio: json["audio"],
        nomor: json["nomor"],
        rukuk: json["rukuk"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "arti": arti,
        "asma": asma,
        "ayat": ayat,
        "nama": nama,
        "type": type,
        "urut": urut,
        "audio": audio,
        "nomor": nomor,
        "rukuk": rukuk,
        "keterangan": keterangan,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [arti, asma, ayat, nama, type, urut, audio, nomor, rukuk, keterangan];
}

class DetailSurah extends Quran {
   String? ar;
  String? id;
  String? no;

  DetailSurah({this.ar, this.id, this.no});

  factory DetailSurah.fromJson(Map<String, dynamic> json) => DetailSurah(
        ar: json["ar"],
        id: json["id"],
        no: json["nomor"]);

  Map<String, dynamic> toJson() => {
        "ar": ar,
        "id": id,
        "nomor": no,
    };



  @override
  // TODO: implement props
  List<Object?> get props => [ar, id, no];
}

class ListDetailSurah extends Equatable {
  String? ar;
  String? id;
  String? no;

  ListDetailSurah({this.ar, this.id, this.no});
  
  factory ListDetailSurah.fromJson(Map<String, dynamic> json) => ListDetailSurah(
        ar: json["ar"],
        id: json["id"],
        no: json["nomor"]);

  Map<String, dynamic> toJson() => {
        "ar": ar,
        "id": id,
        "nomor": no,
    };

  @override
  // TODO: implement props
  List<Object?> get props => [ar, id, no];
}