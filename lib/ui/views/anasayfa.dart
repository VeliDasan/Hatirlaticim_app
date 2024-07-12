import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ilacini_unutma/data/entity/ilaclar.dart';
import 'package:ilacini_unutma/renkler.dart';
import 'package:ilacini_unutma/ui/cubit/anasayfa_cubit.dart';
import 'package:ilacini_unutma/ui/views/detay_sayfa.dart';
import 'package:ilacini_unutma/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;


  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().ilaclariYukle();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: yaziRenk3,
        appBar: AppBar(
          backgroundColor: anaRenk,
          centerTitle: true,
          title: aramaYapiliyorMu
              ? TextField(
            decoration: InputDecoration(hintText: "Ara", hintStyle: TextStyle(color: yaziRenk3)),
            onChanged: (aramaSonucu) {
              context.read<AnasayfaCubit>().ara(aramaSonucu);
            },
          )
              : Text(
            "İlaçlarım",
            style: TextStyle(
              color: yaziRenk3,
              fontFamily: "Bold",
              fontSize: 40,
            ),
          ),
          actions: [
            aramaYapiliyorMu
                ? IconButton(
              onPressed: () {
                setState(() {
                  aramaYapiliyorMu = false;
                });
                context.read<AnasayfaCubit>().ilaclariYukle();
              },
              icon: Icon(Icons.clear, color: yaziRenk3),
            )
                : IconButton(
              onPressed: () {
                setState(() {
                  aramaYapiliyorMu = true;
                });
              },
              icon: Icon(Icons.search, color: yaziRenk3),
            ),
          ],
        ),
        body: BlocBuilder<AnasayfaCubit, List<Ilaclar>>(
          builder: (context, ilacListesi) {
            if (ilacListesi.isNotEmpty) {
              return ListView.builder(
                itemCount: ilacListesi.length,
                itemBuilder: (context, indeks) {
                  var ilac = ilacListesi[indeks];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(

                          builder: (context) => DetaySayfa(ilac: ilac, title: '',),
                        ),
                      ).then((value) {
                        context.read<AnasayfaCubit>().ilaclariYukle();
                      });
                    },
                    child: Card(
                      color: Color(0xFF77B0AA),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ilac.ilac_ad,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Bold",
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    ilac.ilac_doz,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Bold",
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  GestureDetector(
                                    onTap: () async {
                                      TimeOfDay? pickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        setState(() {
                                          ilac.ilac_saat = pickedTime.format(context);
                                        });
                                      }
                                    },
                                    child: Text(
                                      ilac.ilac_saat,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Bold",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${ilac.ilac_ad} silinsin mi?",
                                      style: const TextStyle(fontSize: 20, fontFamily: "Bold"),
                                    ),
                                    action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: () {
                                        context.read<AnasayfaCubit>().sil(ilac.ilac_id);
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
              );
            } else {
              return const Center(
                child: Text(
                  "İlaç listesi boş.",
                  style: TextStyle(fontFamily: "Bold", fontSize: 30),
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KayitSayfa(title: '',)),
              ).then((value) {
                context.read<AnasayfaCubit>().ilaclariYukle();
              });
            },
            backgroundColor: anaRenk,
            child: Icon(Icons.add, color: yaziRenk3),
            ),
        );
    }
}