import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilacini_unutma/data/entity/ilaclar.dart';
import 'package:ilacini_unutma/renkler.dart';
import 'package:ilacini_unutma/ui/cubit/detay_sayfa_cubit.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../../Services/notifi_service.dart';

DateTime scheduleTime = DateTime.now();

class DetaySayfa extends StatefulWidget {
  final Ilaclar ilac;
  final String title;
  DetaySayfa({required this.ilac, required this.title});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfIlacAdi = TextEditingController();
  var tfIlacDoz = TextEditingController();

  @override
  void initState() {
    super.initState();
    var ilac = widget.ilac;
    tfIlacAdi.text = ilac.ilac_ad;
    tfIlacDoz.text = ilac.ilac_doz;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yaziRenk3,
      appBar: AppBar(
        iconTheme:const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: anaRenk,
        centerTitle: true,
        title: Text(
          "Düzenle",
          style: TextStyle(fontSize: 40, fontFamily: "Bold", color: yaziRenk3),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const DatePickerTxt(),
              TextField(
                controller: tfIlacAdi,
                decoration: InputDecoration(
                  hintText: "İlaç Adı",
                  hintStyle: TextStyle(color: yaziRenk3),
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  fillColor: yaziRenk1,
                ),
              ),
              TextField(
                style: TextStyle(color: yaziRenk3),
                controller: tfIlacDoz,
                decoration: InputDecoration(
                  hintText: "İlaç Dozu",
                  hintStyle: TextStyle(color: yaziRenk3),
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  fillColor: yaziRenk1,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  String formattedTime = "${scheduleTime.hour.toString().padLeft(2, '0')}:${scheduleTime.minute.toString().padLeft(2, '0')}";
                  context.read<DetaySayfaCubit>().guncelle(
                    widget.ilac.ilac_id,  // Pass the ilac_id
                    tfIlacAdi.text,
                    tfIlacDoz.text,
                    formattedTime,
                  );

                  // Schedule the notification with medication details
                  NotificationService().scheduleNotification(
                    title: 'İlaç Hatırlatıcısı',
                    body: 'İlaç: ${tfIlacAdi.text}\nDoz: ${tfIlacDoz.text}',
                    scheduledNotificationDateTime: scheduleTime,
                  );

                  // Show the success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Güncelleme gerçekleşti.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: anaRenk,
                ),
                child: Text(
                  "Güncelle",
                  style: TextStyle(fontFamily: "Bold", fontSize: 25, color: yaziRenk3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({Key? key}) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) => setState(() {
            scheduleTime = date;
          }),
          onConfirm: (date) {
            setState(() {
              scheduleTime = date;
            });
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: yaziRenk1, // Background color
        foregroundColor: yaziRenk3, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        'İlaç Saatini Seç',
        style: TextStyle(fontSize: 25, fontFamily: "Bold", color: yaziRenk3),
      ),
    );
  }
}
