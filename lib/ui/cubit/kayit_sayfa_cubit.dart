import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilacini_unutma/data/repo/ilaclardao_repository.dart';

class KayitSayfaCubit extends Cubit<void> {
  KayitSayfaCubit():super(0);

  var irepo = IlaclardaoRepository();

  Future<void> kaydet(String ilac_ad,String ilac_doz,String ilac_saat) async {
    await irepo.kaydet(ilac_ad, ilac_doz,ilac_saat);
  }
}