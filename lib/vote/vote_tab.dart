import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/vote/vote_controller.dart';
import '../widgets/number_input.dart';
import 'vote_model.dart';

class VoteTab extends StatefulWidget {
  const VoteTab({Key? key}) : super(key: key);

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
      controller.addVote(
          VoteCorrect(listNumber: _list!, candidateNumber: _candidate!));
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

      controller.addVote(VoteFail(reason: reason));
    };
  }

  @override
  Widget build(BuildContext context) {
    VoteController controller = Get.put(VoteController());

    List<Widget> failButtons = [
      const Text("Aby podliczy głos nieważny, wybierz powód nieważności:"),
    ];
    for (var i = 0; i < VoteFail.reasons.length; i++) {
      failButtons.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: _voteFail(controller, i),
            child: Text(VoteFail.reasons[i])),
      ));
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
