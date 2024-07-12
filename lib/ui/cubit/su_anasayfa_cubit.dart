import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilacini_unutma/data/entity/sular.dart';
import 'package:ilacini_unutma/data/repo/sulardao_repository.dart';

class SuAnasayfaCubit extends Cubit<List<Sular>> {
  SuAnasayfaCubit(this.srepo) : super(<Sular>[]);

  final SulardaoRepository srepo;

  Future<void> sulariYukle() async {
    var liste = await srepo.sulariYukle();
    emit(liste);
  }

  Future<void> sil(int su_id) async {
    await srepo.sil(su_id);
    await sulariYukle();
  }

  Future<void> kaydet(String su_miktar) async {
    await srepo.kaydet(su_miktar);
    await sulariYukle();
  }
}

