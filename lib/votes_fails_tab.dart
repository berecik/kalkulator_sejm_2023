import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/vote/vote_controller.dart';
import '/vote/vote_model.dart';

class VotesFailsTab extends StatelessWidget {
  const VotesFailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoteController>(builder: (VoteController controller) {
      List<VoteFail>? votes = controller.votesFails;

      if (votes == null || votes.isEmpty) {
        return const Center(child: Text('Brak głosów'));
      }

      Map<int, int> reasons = {};
      votes?.forEach((vote) {
        if (reasons.containsKey(vote.reason)) {
          reasons[vote.reason] = reasons[vote.reason]! + 1;
        } else {
          reasons[vote.reason] = 1;
        }
      });

      List<Widget> results = [];
      for(int i = 0; i < VoteFail.reasons.length; i++) {
        results.add(ListTile(
          title: Text('Powód ${VoteFail.reasons[i]}'),
          subtitle: Text('Liczba głosów: ${reasons[i] ?? 0}'),
        ));
      }

      return Container(
          child: Column(
        children: [
          Text('Liczba głosów nieważnych: ${votes.length}'),
          ...results,
        ],
      ));
    });
  }
}
