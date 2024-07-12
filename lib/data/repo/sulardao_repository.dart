import 'package:ilacini_unutma/data/entity/sular.dart';
import 'package:ilacini_unutma/sqlite/veritabani_yardimcisi2.dart';

class SulardaoRepository {
  // Su miktarını kaydetme metodu
  Future<void> kaydet(String su_miktar) async {
    var db = await VeritabaniYardimcisi2.veritabaniErisim();
    var yeniSu = <String, dynamic>{
      "su_miktar": su_miktar,
      "su_saat": DateTime.now().toString() // Su miktarı eklenme zamanı
    };
    await db.insert("sular", yeniSu);
  }

  // Veritabanındaki tüm su miktarlarını yükleme metodu
  Future<List<Sular>> sulariYukle() async {
    var db = await VeritabaniYardimcisi2.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM sular");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Sular(
        su_id: satir["su_id"],
        su_miktar: satir["su_miktar"] ?? '', // Null kontrolü
        su_saat: satir["su_saat"] ?? '', // Null kontrolü
      );
    });
  }

  // Belirli bir su miktarını silme metodu
  Future<void> sil(int su_id) async {
    var db = await VeritabaniYardimcisi2.veritabaniErisim();
    await db.delete("sular", where: "su_id = ?", whereArgs: [su_id]);
  }
}
