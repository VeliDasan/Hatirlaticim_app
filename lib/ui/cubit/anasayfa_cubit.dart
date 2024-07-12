import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilacini_unutma/data/entity/ilaclar.dart';
import 'package:ilacini_unutma/data/repo/ilaclardao_repository.dart';


class AnasayfaCubit extends Cubit<List<Ilaclar>> {
  AnasayfaCubit():super(<Ilaclar>[]);

  var irepo = IlaclardaoRepository();

  Future<void> ilaclariYukle() async {
    var liste = await irepo.ilaclariYukle();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {
    var liste = await irepo.ara(aramaKelimesi);
    emit(liste);
  }

  Future<void> sil(int ilac_id) async {
    await irepo.sil(ilac_id);
    await ilaclariYukle();
  }
}