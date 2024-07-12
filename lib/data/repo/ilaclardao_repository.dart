
import 'package:ilacini_unutma/data/entity/ilaclar.dart';
import 'package:ilacini_unutma/sqlite/veritabani_yardimcisi.dart';

class IlaclardaoRepository {


  Future<void> kaydet(String ilac_ad,String ilac_doz,String ilac_saat) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var yeniIlac = Map<String,dynamic>();
    yeniIlac["ilac_ad"] = ilac_ad;
    yeniIlac["ilac_doz"] = ilac_doz;
    yeniIlac["ilac_saat"] = ilac_saat;
    await db.insert("ilaclar", yeniIlac);
  }
  Future<void> guncelle(int ilac_id,String ilac_ad,String ilac_doz,String ilac_saat) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenenIlac = Map<String,dynamic>();
    guncellenenIlac["ilac_ad"] = ilac_ad;
    guncellenenIlac["ilac_doz"] = ilac_doz;
    guncellenenIlac["ilac_saat"] = ilac_saat;
    await db.update("ilaclar", guncellenenIlac,where: "ilac_id = ?",whereArgs: [ilac_id]);
  }

  Future<void> sil(int ilac_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("ilaclar",where: "ilac_id = ?",whereArgs: [ilac_id]);
  }

  Future<List<Ilaclar>> ilaclariYukle() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM ilaclar");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Ilaclar(ilac_id: satir["ilac_id"], ilac_ad: satir["ilac_ad"], ilac_doz: satir["ilac_doz"],ilac_saat: satir["ilac_saat"]);
    });
  }

  Future<List<Ilaclar>> ara(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM ilaclar WHERE ilac_ad like '%$aramaKelimesi%'");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Ilaclar(ilac_id: satir["ilac_id"], ilac_ad: satir["ilac_ad"], ilac_doz: satir["ilac_doz"],ilac_saat: satir["ilac_saat"]);
    });
  }
}