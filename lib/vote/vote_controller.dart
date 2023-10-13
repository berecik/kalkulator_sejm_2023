import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'vote_model.dart';

class VoteController extends GetxController {
  final List<Vote> _votes = [];
  List<Vote> get votes => _votes;

  void addVote(Vote vote){
    _votes.add(vote);
    if (kDebugMode) {
      print("${_votes.length}: ${vote.toString()}");
    }
    update();
  }

  List<VoteFail>? get votesFails {
    return _votes.whereType<VoteFail>().toList();
  }

  List<VoteCorrect>? get votesCorrect {
    return _votes.whereType<VoteCorrect>().toList();
  }

  List<VoteCorrect>? votesLists(int listNumber) {
    List<VoteCorrect>? votes = votesCorrect?.where((vote) => vote.listNumber == listNumber).toList();
    if (kDebugMode) {
      print("Votes for list $listNumber: $votes");
    }
    return votes;
  }

}