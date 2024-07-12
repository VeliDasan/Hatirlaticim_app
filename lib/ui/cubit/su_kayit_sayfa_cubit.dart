import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilacini_unutma/data/repo/sulardao_repository.dart';

class SuKayitSayfaCubit extends Cubit<void> {
  final SulardaoRepository srepo;

  SuKayitSayfaCubit(this.srepo) : super(0);

  Future<void> kaydet(String su_miktar) async {
    await srepo.kaydet(su_miktar);
    // Kayıt işleminden sonra güncelleme yaparak listenin yeniden yüklenmesini tetikleyebilirsiniz.
  }
}
