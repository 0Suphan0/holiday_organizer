import 'package:flutter/material.dart';
import '../CustomStyle/app_style.dart';

class FullScreenDialog extends StatelessWidget {
  final String? result;

  FullScreenDialog({required this.result});

  @override
  Widget build(BuildContext context) {
    // Gelen result değerini parçala ve listeye ata...
    List<String> sentences = result?.split('\n') ?? [];
    sentences.removeLast();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: AppStyle.appBarGradient,
        ),
        title: Text(
          "GORA'nın Planı",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "GORA Sizin İçin ${sentences.length} adet etkinlik hazırladı",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: sentences.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: AppStyle.buttonColor, // Kart arka plan rengi
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        title: Text("ETKİNLİK ${index+1}",style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle:Text(
                            sentences[index],
                            style: TextStyle(fontSize: 20),
                        ),
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
