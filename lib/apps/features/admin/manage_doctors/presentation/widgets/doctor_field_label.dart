import 'package:flutter/material.dart';

import '../../../../../../generated/style_atoms.dart';

class DoctorFormFieldLabel extends StatelessWidget {
  const DoctorFormFieldLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: context.medium16Dark);
  }
}
