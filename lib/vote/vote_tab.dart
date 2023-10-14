import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalkulator_sejm_2023/widgets/fail_reason_button.dart';
import '../lists/lists_controller.dart';
import '/vote/vote_controller.dart';
import '../widgets/number_input.dart';
import 'vote_model.dart';
import 'package:slider_button/slider_button.dart';

class VoteTab extends StatefulWidget {
  const VoteTab({Key? key, required this.checkList}) : super(key: key);

  final Function checkList;

  @override
  State<VoteTab> createState() => _VoteTabState();
}

class _VoteTabState extends State<VoteTab> {
  int? _list;
  int? _candidate;

  // final List<Vote> votes = [];

  late NumberInput listNumberField;
  late NumberInput candidateNumberField;

  NumberInput getListNumber() {
    return NumberInput(
      key: UniqueKey(),
      label: 'Numer listy',
      onChanged: (int value) {
        print("List number changed to $value");
        setState(() {
          _list = value;
        });
      },
    );
  }

  NumberInput getCandidateNumber() {
    return NumberInput(
      key: UniqueKey(),
      label: 'Numer kandydata',
      onChanged: (int value) {
        print("Candidate number changed to $value");
        setState(() {
          _candidate = value;
        });
      },
    );
  }

  @override
  void initState() {
    listNumberField = getListNumber();
    candidateNumberField = getCandidateNumber();
    super.initState();
  }

  _voteCorrect(VoteController controller) {
    return () {
      if (kDebugMode) {
        print("Głos ważny $_list $_candidate");
      }
      VoteCorrect vote = VoteCorrect(listNumber: _list!, candidateNumber: _candidate!);
      Get.snackbar("Głos ważny", vote.toString());
      widget.checkList(_list!);
      controller.addVote(vote);
      setState(() {
        _list = null;
        _candidate = null;
        listNumberField = getListNumber();
        candidateNumberField = getCandidateNumber();
      });
    };
  }

  _voteFail(VoteController controller, int reason) {
    return () {
      if (kDebugMode) {
        print("Głos nieważny ${VoteFail.reasons[reason]}");
      }
      VoteFail vote = VoteFail(reason: reason);
      Get.snackbar("Głos nieważny", vote.toString());
      controller.addVote(vote);
    };
  }

  @override
  Widget build(BuildContext context) {
    VoteController controller = Get.put(VoteController());

    List<Widget> failButtons = [
      const Text("Aby podliczy głos nieważny, wybierz powód nieważności:"),
    ];
    for (var i = 0; i < VoteFail.reasons.length; i++) {
      failButtons.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:FailReasonButton(
            label: VoteFail.reasons[i],
            action: _voteFail(controller, i),
          ),
          // SliderButton(
          //   width: double.maxFinite,
          //   action: _voteFail(controller, i),
          //   // dismissible: false,
          //   label: Text(
          //     VoteFail.reasons[i],
          //     style: const TextStyle(
          //         color: Color(0xff4a4a4a),
          //         fontWeight: FontWeight.w500,
          //         fontSize: 17),
          //   ),
          //   icon: const Text(
          //     "x",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.w400,
          //       fontSize: 44,
          //     ),
          //   ),
          // ),
          //   ElevatedButton(
          //       onPressed: _voteFail(controller, i),
          //       child: Text(VoteFail.reasons[i])),
          // ),
        ),
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: listNumberField,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: candidateNumberField,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (_list != null && _candidate != null)
                      ? _voteCorrect(controller)
                      : null,
                  child: const Text("Podlicz głos ważny"),
                ),
              ),
              const Text("Wprowadź numer listy i kandydata aby podliczyć głos.")
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: failButtons,
          ),
        ),
      ],
    );
  }
}
