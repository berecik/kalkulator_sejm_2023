import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';

class FailReasonButton extends StatelessWidget {
  const FailReasonButton({
    Key? key,
    required this.action,
    required this.label,
  }) : super(key: key);
  final Function() action;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Text(
            label,
            maxLines: 2,
            softWrap: true,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              // fontSize: 20,
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 60,
          child: SlideAction(
            trackBuilder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text("Przesuń",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              );
            },
            thumbBuilder: (context, state) {
              return Container(
                // width: 400,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              );
            },
            action: action,
          ),
        ),
      ],
    );
  }
}
