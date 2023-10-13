abstract class Vote {
  bool active = true;
  final datetime = DateTime.now();

  @override
  String toString() {
    // TODO: implement toString
    return "[$datetime] ";
  }
}

class VoteCorrect extends Vote {
  final int listNumber;
  final int candidateNumber;

  VoteCorrect({required this.listNumber, required this.candidateNumber});

  @override
  String toString() {
    return super.toString() + "Głos poprawny, lista $listNumber, kandydat numer $candidateNumber";
  }
}

class VoteFail extends Vote {
  static List<String> reasons = [
    "Brak X",
    "X przy więcej niż jednej liście.",
    "Lista wycofana.",
    "Brak pieczęci OKW.",
    "Karta nieczytelna/uszkodzona.",
  ];

  final int reason;

  VoteFail({required this.reason});

  @override
  String toString() {
    return super.toString() + "Głos nieważny: ${reasons[reason]}";
  }
}
