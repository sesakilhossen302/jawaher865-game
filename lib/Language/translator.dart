import 'package:get/get.dart';
import 'arabic.dart';
import 'english.dart';

class Translator extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': english,
        'ar_SA': arabic,
      };
}
