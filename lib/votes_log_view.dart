import 'package:flutter/cupertino.dart';
import 'vote/vote_model.dart';
import 'widgets/vote_widget.dart';

class VotesLogView extends StatelessWidget {
  const VotesLogView({super.key, required this.votes});

  final List<Vote> votes;

  @override
  Widget build(BuildContext context) {
    List<VoteWidget> votesWidgets = [];
    for(int i = 0; i < votes.length; i++) {
      votesWidgets.add(VoteWidget(vote: votes[i], index: i));
    }
    return Column(
      children: votesWidgets,
    );
  }
}
