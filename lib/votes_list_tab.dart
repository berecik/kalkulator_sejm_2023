import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kalkulator_sejm_2023/vote/vote_controller.dart';
import 'package:kalkulator_sejm_2023/vote/vote_model.dart';

class VotesListTab extends StatelessWidget {
  const VotesListTab(this.number, {Key? key}) : super(key: key);

  final int number;
  final int amountOfCandidates = 40;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoteController>(builder: (VoteController controller) {
      int maxCandidateNumber = 1;
      List<VoteCorrect>? votes = controller.votesLists(number);

      if (votes == null || votes.isEmpty) {
        return Center(
          child: Text('Brak głosów na listę nr $number'),
        );
      }

      Map<int, int> candidates = {};
      for (int i = 0; i < votes!.length; i++) {
        VoteCorrect vote = votes[i];
        if (candidates.containsKey(vote.candidateNumber)) {
          candidates[vote.candidateNumber] =
              candidates[vote.candidateNumber]! + 1;
        } else {
          candidates[vote.candidateNumber] = 1;
        }
      }

      List<Widget> results = [];

      for (int i = 1; i <= candidates.keys.reduce(max); i++) {
        results.add(ListTile(
          title: Text('Kandydat nr $i'),
          subtitle: Text('Liczba głosów: ${candidates[i] ?? 0}'),
        ));
      }

      return Container(
          child: Column(
        children: [
          Text('Liczba głosów na listę nr $number: ${votes?.length ?? 0}  '),
          ...results,
        ],
      ));
    });
  }
}
