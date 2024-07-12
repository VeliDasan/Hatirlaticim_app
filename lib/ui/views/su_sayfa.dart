import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilacini_unutma/data/entity/sular.dart';
import 'package:ilacini_unutma/ui/cubit/su_anasayfa_cubit.dart';
import 'package:ilacini_unutma/ui/cubit/su_kayit_sayfa_cubit.dart';
import '../../renkler.dart';

class SuSayfa extends StatefulWidget {
  const SuSayfa({Key? key}) : super(key: key);

  @override
  State<SuSayfa> createState() => _SuSayfaState();
}

class _SuSayfaState extends State<SuSayfa> {
  var tfSuMiktari = TextEditingController();
  int toplamSuMiktari = 0;
  bool hedefTamamlandi = false;

  @override
  void initState() {
    super.initState();
    context.read<SuAnasayfaCubit>().sulariYukle();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Su Miktarı Ekle"),
          content: TextField(
            controller: tfSuMiktari,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Örneğin: 250 ml",
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Ekle"),
              onPressed: () {
                int eklenenMiktar = int.tryParse(tfSuMiktari.text) ?? 0;
                context.read<SuAnasayfaCubit>().kaydet(tfSuMiktari.text);
                setState(() {
                  toplamSuMiktari += eklenenMiktar;
                  if (toplamSuMiktari >= 2300) {
                    hedefTamamlandi = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Tebrikler! Hedefinize ulaştınız.",
                          style: const TextStyle(fontSize: 20, fontFamily: "Bold"),
                        ),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 3), () {
                      setState(() {
                        hedefTamamlandi = false;
                      });
                    });
                  }
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Vazgeç"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: anaRenk,
        centerTitle: true,
        title: Text(
          "Su Takibi",
          style: TextStyle(fontSize: 40, fontFamily: "Bold", color: yaziRenk3),
        ),
      ),
      body: BlocBuilder<SuAnasayfaCubit, List<Sular>>(
        builder: (context, suListesi) {
          toplamSuMiktari = calculateTotalWaterAmount(suListesi);

          double percentageFilled = toplamSuMiktari / 2300.0;

          return Column(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: anaRenk, width: 5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: CircularProgressIndicator(
                                    value: percentageFilled,
                                    backgroundColor: Colors.grey[300],
                                    strokeWidth: 10,
                                    valueColor: AlwaysStoppedAnimation<Color>(anaRenk),
                                  ),
                                ),
                                if (hedefTamamlandi)
                                  const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 200,
                                    ),
                                  ),
                                Center(
                                  child: Text(
                                    '${toplamSuMiktari}/${2300} ml',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: suListesi.isNotEmpty
                    ? ListView.builder(
                  itemCount: suListesi.length,
                  itemBuilder: (context, indeks) {
                    var su = suListesi[indeks];
                    return GestureDetector(
                      child: Card(
                        color: const Color(0xFF77B0AA),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${su.su_miktar} ml",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Bold",
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${su.su_miktar} silinsin mi?",
                                        style: const TextStyle(
                                            fontSize: 20, fontFamily: "Bold"),
                                      ),
                                      action: SnackBarAction(
                                        label: "Evet",
                                        onPressed: () {
                                          context.read<SuAnasayfaCubit>().sil(su.su_id);
                                          setState(() {
                                            toplamSuMiktari -= int.tryParse(su.su_miktar) ?? 0;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.clear, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
                    : const Center(
                  child: Text(
                    "Su listesi boş.",
                    style: TextStyle(fontFamily: "Bold", fontSize: 30),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        backgroundColor: anaRenk,
        child: Icon(Icons.add, color: yaziRenk3),
      ),
    );
  }

  // Function to calculate total water amount from the list of waters
  int calculateTotalWaterAmount(List<Sular> suListesi) {
    int total = 0;
    suListesi.forEach((su) {
      total += int.tryParse(su.su_miktar) ?? 0;
    });
    return total;
  }

  @override
  void dispose() {
    tfSuMiktari.dispose();
    super.dispose();
  }
}
