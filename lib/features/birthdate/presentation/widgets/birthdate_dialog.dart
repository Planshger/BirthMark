import 'package:flutter/cupertino.dart';

class BirthdateDialog extends StatefulWidget{
  final String initialName;
  final DateTime initialBirthdate;
  final Function(String name, DateTime birthDate) onSave;

  BirthdateDialog({super.key, this.initialName = '', required this.onSave, DateTime? initialBirthdate}) : initialBirthdate = initialBirthdate ?? DateTime.now();

  @override
  State<BirthdateDialog> createState() => _BirthdateDialogState();
}

class _BirthdateDialogState extends State<BirthdateDialog> {
  late TextEditingController _nameController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _selectedDate = widget.initialBirthdate;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Добавить др'),
      content: Column(
        children: [
          CupertinoTextField(
            controller: _nameController,
            placeholder: 'Имя',
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _selectedDate,
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  _selectedDate = newDateTime;
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('Отмена'),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: Text('Сохранить'),
          onPressed: () { 
            final name = _nameController.text;
            if (name.isEmpty) return;
            widget.onSave(name, _selectedDate);
            Navigator.pop(context);
          }
          
        )
      ]
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
