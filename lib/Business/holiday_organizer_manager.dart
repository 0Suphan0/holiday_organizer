import 'dart:math';
import 'package:holiday_organizer/Business/all_activities.dart';
import '../Models/form_view_model.dart';

class HolidayOrganizerManager {

  String myResult = "";

  String? createPlan(FormViewModel formViewModel) {

    String result;

    //Eğer seçilen tür eğlence ise ona göre bir plan olustur..
    if (formViewModel.holidayType == "Eğlence")
    {
      result =  calculateHoliday(formViewModel, Activities.funActivities);
      return result;
    }
    else if (formViewModel.holidayType == "Deniz")
    {
      result =  calculateHoliday(formViewModel, Activities.seaActivities);
      return result;
    }
    else if (formViewModel.holidayType == "Doğa")
    {
      result =  calculateHoliday(formViewModel, Activities.natureActivities);
      return result;
    }else if(formViewModel.holidayType == "Kış")
    {
      result =  calculateHoliday(formViewModel, Activities.winterActivities);
      return result;
    }
    else if (formViewModel.holidayType == "Kültür")
    {
      result =  calculateHoliday(formViewModel, Activities.cultureActivities);
      return result;
    }
    return null;
  }

  String calculateHoliday(FormViewModel formViewModel, List<String> activities) {
    //sonucu bu stringte birlestirecegiz..
    String myResult = "";

    Random random = Random();
    int randomMonth;
    int randomDay;

    //Eger mevcut yılın içindeysek kalan aylara göre plan yap. Geçmiş aylara göre değil!.
    if (formViewModel.holidayYear == DateTime.now().year) {
      int currentMonth = DateTime.now().month;
      List<int> laterMonths = [];

      // Şu anki aydan sonraki ayları listeye ekle.
      for (int i = currentMonth + 1; i <= 12; i++) {
        laterMonths.add(i);
      }
      //eger bulundugumuz yılda ve deniz ise önümüzde hangi deniz ayı kaldıysa onları filtrele...
      if(formViewModel.holidayType == "Deniz") {
        laterMonths = laterMonths.where((element) => element == 6 || element == 7 || element == 8).toList();
      }

      //eger bulundugumuz yılda ve kış ise önümüzde hangi kış ayı kaldıysa onları filtrele...
      if(formViewModel.holidayType == "Kış") {
        laterMonths = laterMonths.where((element) => element == 12 || element == 1 || element == 2).toList();
      }
      // Sonraki kalan aylardan rastgele birini seç.
      randomMonth = laterMonths[random.nextInt(laterMonths.length)];
    }
    else {
      // Tatil yılı önümüzdeki yıllardan biriyse, rastgele bir ay seçilebilir..
      randomMonth = random.nextInt(12) + 1;

      // Tatil türü önümüzdeki yıl ama deniz veya kış tatiliyse uygun ayları seçme islemini yap..
      if (formViewModel.holidayType == "Deniz") {
        //deniz tatilini yaz aylarından ver.
        List<int> summerMonths = [6, 7, 8];
        randomMonth = summerMonths[random.nextInt(3)];
      }
      else if (formViewModel.holidayType == "Kış") {
        //kış tatilini kış aylarından ver.
        List<int> winterMonths = [12, 1, 2];
        randomMonth = winterMonths[random.nextInt(3)];
      }
    }
    // Rastgele gün seç
    randomDay = random.nextInt(28) + 1;


    List<int> randomDays = [];
    int totalDays=formViewModel.holidayDays; // toplam tatil süresi.

    // Zamanı belirle form'dan gelen yıl, uygun aralıkta random ay ve gün ile.
    DateTime time = DateTime(formViewModel.holidayYear, randomMonth, randomDay);

  //bu for döngüsü activitelere göre zamanı randomize bir sekilde böler.
    for (int i = 0; i < activities.length - 1; i++) {
      int randomSplit = random.nextInt(totalDays - (activities.length - i - 1)) + 1;
      randomDays.add(randomSplit);
      totalDays -= randomSplit;
    }
    randomDays.add(totalDays);

    // Random aktiviteler listesinin kopyasını alıyorum cünkü aynı aktivite plana dahil edilmesin
    List<String> randomActivities = List.from(activities);

    for (int i = 0; i < activities.length; i++) {
      int randomActivityIndex = random.nextInt(randomActivities.length); // Rastgele aktivite indexi seç
      String randomActivity = randomActivities[randomActivityIndex];

      //planı olustur ve zamanı random bölünmüs ve secilmis zaman aralıgı kadar ileri cek.
      myResult += "${time.year}-${time.month}-${time.day} tarihinden başlayarak ${randomDays[i]} gün  ${randomActivity} etkinliği yapacağız. \n";
      time = time.add(Duration(days: randomDays[i])); //

      // Seçilen aktiviteyi listeden çıkar, aynısını secmesin. Aynı etkinlik sıkıcı olur.
      randomActivities.removeAt(randomActivityIndex);
    }
    return myResult;
  }

}


