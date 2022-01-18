import '../models/quran_model.dart';
import '../services/quran_services.dart';

class QuranRepository{
  
  final QuranService quranService;

  QuranRepository(this.quranService);

  Future<List<Quran>> fetchQurans() async{
    final quran = await quranService.fetchSurah();

    return quran.map((e) => Quran.fromJson(e)).toList();
  }
}