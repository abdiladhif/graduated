import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'quran_reference_screen.dart';
import 'share_data.dart';
import 'api_service.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  ResultScreen({required this.result});

  final Map<String, List<String>> quranicTexts = {
    "Xaasaska Qaybtooda": [
      "وَلَهُنَّ الرُّبُعُ مِمَّا تَرَكْتُمْ إِنْ لَمْ يَكُنْ لَكُمْ وَلَدٌ ۖ فَإِنْ كَانَ لَكُمْ وَلَدٌ فَلَهُنَّ الثُّمُنُ مِمَّا تَرَكْتُمْ...",
      "Waxaa naagaha idinka midka ah idiin leh rubac ka mid ah waxa aad ka tagteen haddii aysan ilmo idiin dhallan, haddii ilmo idiin dhashana waxay ku leeyihiin siddeed miisaan."
    ],
    "Ninka Qaybtiisa": [
      "وَلَكُمْ نِصْفُ مَا تَرَكَ أَزْوَاجُكُمْ إِنْ لَمْ يَكُنْ لَهُنَّ وَلَدٌ فَإِنْ كَانَ لَهُنَّ وَلَدٌ فَلَكُمُ الرُّبُعُ مِمَّا تَرَكْنَ...",
      "Waxaa raggaga idiin leh kala badh waxa ay ka tagaan naagihiina haddii aysan ilmo lahayn, haddii ilmo lahaadana idinku waxa aad leedihiin rubac ka mid ah waxa ay ka tageen."
    ],
    "Aabaha qaybtiisa": [
      "وَلِأَبَوَيْهِ لِكُلِّ وَاحِدٍ مِنْهُمَا السُّدُسُ مِمَّا تَرَكَ إِنْ كَانَ لَهُ وَلَدٌ ۖ فَإِنْ لَمْ يَكُنْ لَهُ وَلَدٌ وَوَرِثَهُ أَبَوَاهُ فَلِأُمِّهِ الثُّلُثُ...",
      "Waxaa aabaha iyo hooyada mid kasta oo ka mid ahi ka leh lixaad meel waxa uu ka tagay haddii uu ilmo leeyahay, haddii uusan ilmo lahayn waxaa hooyada u leh saddex meelood meel."
    ],
    "Hooyada Qaybteeda": [
      "وَلِأَبَوَيْهِ لِكُلِّ وَاحِدٍ مِنْهُمَا السُّدُسُ مِمَّا تَرَكَ إِنْ كَانَ لَهُ وَلَدٌ ۖ فَإِنْ لَمْ يَكُنْ لَهُ وَلَدٌ وَوَرِثَهُ أَبَوَاهُ فَلِأُمِّهِ الثُّلُثُ...",
      "Waxaa aabaha iyo hooyada mid kasta oo ka mid ahi ka leh lixaad meel waxa uu ka tagay haddii uu ilmo leeyahay, haddii uusan ilmo lahayn waxaa hooyada u leh saddex meelood meel."
    ],
    "Wilasha Qeebtoda": [
      "يُوصِيكُمُ اللَّهُ فِي أَوْلَادِكُمْ ۖ لِلذَّكَرِ مِثْلُ حَظِّ الأُنثَيَيْنِ...",
      "Ilaahay waxa uu idiinku dardaarmayaa carruurtiinna. Wiilka waxa uu leeyahay labo gabdhood intay leeyihiin."
    ],
    "Gabdhaha Qaybtooda": [
      "فَإِنْ كُنَّ نِسَاءً فَوْقَ اثْنَتَيْنِ فَلَهُنَّ ثُلُثَا مَا تَرَكَ ۖ وَإِنْ كَانَتْ وَاحِدَةً فَلَهَا النِّصْفُ...",
      "Haddii ay gabdhuhu ka badan yihiin labo, waxay leeyihiin saddex meelood laba waxa uu ka tagay, haddii ay mid tahay waxay leedahay kala badh."
    ],
    "Walaalaha Qeebtoda/Wilasha/Gabdhaha": [
      "وَإِن كَانَ رَجُلٌ يُورَثُ كَلَٰلَةً أَوِ ٱمْرَأَةٌ وَلَهُٓ أَخٌ أَوْ أُخْتٌ فَلِكُلِّ وَاحِدٍۢ مِّنْهُمَا ٱلسُّدُسُ ۚ فَإِن كَانُوٓا۟ أَكْثَرَ مِن ذَٰلِكَ فَهُمْ شُرَكَآءُ فِى ٱلثُّلُثِ...",
      "Haddii nin ama naag loo dhaxlayo ay leeyihiin walaal ama walaalo, mid kasta oo ka mid ah waxay leeyihiin lixaad, haddii ay ka badan yihiin waxay wadaagaan saddex meelood."
    ],
    "Awoowaha/Ayeeyo Qeebtooda": [
      "فَإِنْ لَمْ يَكُنْ لَهُ وَلَدٌ فَلَهُنَّ الثُّمُنُ",
      "Haddii aysan ilmo lahayn waxay leeyihiin siddeed miisaan."
    ],
    "Paternal Grandfather Share": [
      "فَإِنْ كَانَ لَهُ وَلَدٌ فَلَهُ الثُّمُنُ",
      "Haddii uu ilmo leeyahay, waxay leeyihiin siddeed miisaan."
    ],
  };

  @override
  Widget build(BuildContext context) {
    Map<String, num> shares = Map<String, num>.from(result["shares"]);
    Map<String, String> references = Map<String, String>.from(result["references"]);
    double totalAmount = result["totalAmount"] ?? 0.0;

    List<Color> colors = [
      Colors.blue, Colors.green, Colors.red, Colors.orange,
      Colors.purple, Colors.cyan, Colors.yellow, Colors.pink,
      Colors.teal, Colors.brown, Colors.indigo, Colors.lime,
    ];

    List<ShareData> chartData = shares.entries
        .where((entry) => entry.value != 0 && !entry.key.endsWith("Walbo") && entry.key != "lacagta guud")
        .map((entry) => ShareData(entry.key, entry.value.toDouble(), colors[shares.keys.toList().indexOf(entry.key) % colors.length]))
        .toList();

    double totalShare = chartData.fold(0, (sum, entry) => sum + entry.share);

    List<PieSeries<ShareData, String>> series = [
      PieSeries<ShareData, String>(
        dataSource: chartData,
        xValueMapper: (ShareData data, _) => data.heir,
        yValueMapper: (ShareData data, _) => data.share,
        pointColorMapper: (ShareData data, _) => data.color,
        dataLabelMapper: (ShareData data, _) => totalShare != 0 ? '${(data.share / totalShare * 100).toStringAsFixed(1)}%' : '0%',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,
          textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        explode: true,
        explodeIndex: 0,
        radius: '80%',
      ),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        ApiService apiService = ApiService();
        await apiService.saveResult(result);
        print('Result saved successfully');
      } catch (e) {
        print('Failed to save result: $e');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Natiijada Dhaxalka'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Qaybta la dhaxlaayo:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            if (totalAmount != 0)
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: Colors.teal),
                  title: Text(
                    'Lacagta Guud: ${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ...shares.entries.where((entry) => entry.value != 0).map((entry) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.pie_chart, color: Colors.teal),
                  title: Text(
                    '${entry.key}: ${(entry.value).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              );
            }).toList(),
            if (chartData.isNotEmpty)
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SfCircularChart(
                    title: ChartTitle(
                      text: 'Qaabka loo Kala dhaxlay',
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap,
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    series: series,
                  ),
                ),
              ),
            SizedBox(height: 20),
            Text(
              'Daliilka Ayada Qur,aanka:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            ...references.entries.map((entry) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.book, color: Colors.teal),
                  title: Text(entry.key, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  subtitle: Text(entry.value),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuranReferenceScreen(
                          referenceTitle: entry.key,
                          referenceText: quranicTexts[entry.key] != null ? quranicTexts[entry.key]!.join('\n\n') : "Reference text not available.",
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}