import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kalkulator_sejm_2023/vote/vote_controller.dart';
import 'vote/vote_model.dart';
import 'widgets/vote_widget.dart';
import 'votes_log_view.dart';

class VotesLogTab extends StatelessWidget {
  const VotesLogTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoteController>(
        builder: (VoteController controller){
          return VotesLogView(votes: controller.votes);
        });
  }
}
