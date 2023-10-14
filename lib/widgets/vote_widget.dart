import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalkulator_sejm_2023/vote/vote_controller.dart';
import '../vote/vote_model.dart';

class VoteWidget extends StatelessWidget {
  VoteWidget({Key? key, required this.vote, required this.index})
      : super(key: key);

  final Vote vote;
  final int index;
  VoteController voteController = Get.put(VoteController());

  @override
  Widget build(BuildContext context) {
    Function() onPressed;
    Widget child;

    if (vote.active) {
      onPressed = () {
        voteController.disableVote(index);
      };
      child = const Text(
        "Cofnij głos",
      );
    } else {
      onPressed = () {
        voteController.enableVote(index);
      };
      child = const Text(
        "Aktywuj głos",
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: onPressed,
              child: child,
            ),
            Text(
              vote.toString(),
              style: TextStyle(
                backgroundColor: vote.active ? Colors.white : Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
