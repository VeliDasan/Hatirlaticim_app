import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilacini_unutma/data/repo/ilaclardao_repository.dart';


class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit():super(0);

  var irepo = IlaclardaoRepository();

  Future<void> guncelle(int ilac_id,String ilac_ad,String ilac_doz,String ilac_saat) async {
    await irepo.guncelle(ilac_id, ilac_ad, ilac_doz,ilac_saat);
  }
}