import 'package:get/get.dart';
import 'votes_list_tab.dart';

class ListsController extends GetxController {
  final Map<int, VotesListTab> _votesLists = {};

  void checkList(int listNumber) {
    if (!_votesLists.containsKey(listNumber)) {
      _votesLists[listNumber] = VotesListTab(listNumber);
      update();
    }
  }

  Map<int, VotesListTab>  get votesLists => Map.fromEntries(_votesLists.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

}
