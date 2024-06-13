import 'package:flutter/material.dart';
import 'package:holiday_organizer/Models/form_view_model.dart';
import '../Business/holiday_organizer_manager.dart';
import '../CustomStyle/app_style.dart';
import 'full_screen_dialog.dart';


class HolidayOrganizerScreen extends StatefulWidget {
  const HolidayOrganizerScreen({super.key});

  @override
  _HolidayOrganizerScreenState createState() => _HolidayOrganizerScreenState();
}

class _HolidayOrganizerScreenState extends State<HolidayOrganizerScreen> {


  final _formKey = GlobalKey<FormState>(); // Validation icin form anahtarı..
  final _yearController = TextEditingController();
  final _holidayDayController = TextEditingController();
  String _holidayType = 'Eğlence';

  String? _result = '';

  void _createHoliday() {
    if (_formKey.currentState!.validate()) {
      final year = int.parse(_yearController.text);
      final holidayDay = int.parse(_holidayDayController.text);
      final organizer = HolidayOrganizerManager();
      final result = organizer.createPlan(FormViewModel(holidayYear: year, holidayDays: holidayDay, holidayType: _holidayType));

      setState(() {
        _result = result;
      });

      _showFullScreenDialog(_result);

    }
  }

  // sonucu diger sayfaya gönder ve ac..
  void _showFullScreenDialog(String? sonuc) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => FullScreenDialog(result: sonuc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: AppStyle.appBarGradient,
          ),
          title: const Center(child: Text('GORA ile iyi bir MOLA :) ')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // SingleChildScrollView ekleniyor
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(child: Image.asset("images/gora.jpg") ,width: 285),
                TextFormField(
                  controller: _yearController,
                  decoration: const InputDecoration(labelText: 'Tatil Yılı'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen tatil yılı giriniz';
                    }
                    int? parsedValue = int.tryParse(value);
                    if (parsedValue == null) {
                      return 'Lütfen geçerli bir yıl giriniz';
                    }
                    if (parsedValue < DateTime.now().year) {
                      return 'Geçmiş yılları giremezsiniz';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _holidayDayController,
                  decoration: const InputDecoration(labelText: 'İzin Sayısı'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen izin sayısını giriniz';
                    }
                    int? parsedValue = int.tryParse(value);
                    if (parsedValue == null) {
                      return 'Lütfen geçerli bir sayı giriniz';
                    }
                    if (parsedValue < 5 || parsedValue > 20) {
                      return 'İzin sayısı 5 ile 20 arasında olmalıdır';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _holidayType,
                  items: ['Eğlence', 'Deniz', 'Doğa', 'Kültür',"Kış"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _holidayType = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Tatil Tipi'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _createHoliday,
                  child: const Text('Tatil Planla'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppStyle.buttonColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}