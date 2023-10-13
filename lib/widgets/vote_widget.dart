import 'package:flutter/cupertino.dart';
import '../vote/vote_model.dart';

class VoteWidget extends StatelessWidget {
  const VoteWidget({Key? key, required this.vote}) : super(key: key);

  final Vote vote;

  @override
  Widget build(BuildContext context) {
    return Text(vote.toString());
  }
}