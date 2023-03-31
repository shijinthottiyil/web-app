import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  AlertDialogWidget({
    super.key,
    required TextEditingController nameController,
    required TextEditingController ageController,
    required TextEditingController batchController,
    required TextEditingController courseController,
    required this.mainName,
    required this.buttonName,
    required this.isLoad,
    required this.onTapFn,
    this.nameLabel,
    this.ageLabel,
    this.batchLabel,
    this.courseLabel,
  })  : _nameController = nameController,
        _ageController = ageController,
        _batchController = batchController,
        _courseController = courseController;

  final TextEditingController _nameController;
  final TextEditingController _ageController;
  final TextEditingController _batchController;
  final TextEditingController _courseController;
  final String mainName;
  final String buttonName;
  VoidCallback onTapFn;
  bool isLoad;
  String? nameLabel;
  String? ageLabel;
  String? batchLabel;
  String? courseLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(mainName),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: nameLabel ?? 'name'),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _ageController,
            decoration: InputDecoration(labelText: ageLabel ?? 'age'),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _batchController,
            decoration: InputDecoration(labelText: batchLabel ?? 'batch'),
          ),
          TextField(
            controller: _courseController,
            decoration: InputDecoration(labelText: courseLabel ?? 'course'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onTapFn,
          child: isLoad ? CircularProgressIndicator() : Text(buttonName),
        ),
      ],
    );
  }
}
