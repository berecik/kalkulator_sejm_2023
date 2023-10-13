import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  NumberInput({
    required this.label,
    required this.onChanged,
    super.key,
    this.value,
  });

  int? value;
  String label;
  final Function onChanged;

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  int? _value;
  late TextField field;

  int? get value => _value;

  set value(int? value) {
    setState(() {
      _value = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    field = TextField(
      decoration: InputDecoration(labelText: widget.label),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
      onChanged: (String value) {
        int intValue = int.parse(value);
        widget.onChanged(intValue);
        setState(() {
          _value = intValue;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return field;
  }
}
