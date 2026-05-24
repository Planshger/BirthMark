import 'package:flutter/cupertino.dart';
import '../../domain/entities/wish.dart';

class WishDialog extends StatefulWidget {
  final Wish? wish;
  final Function(Wish) onSave;
  const WishDialog({super.key, this.wish, required this.onSave});

  @override
  State<WishDialog> createState() => _WishDialogState();
}

class _WishDialogState extends State<WishDialog> {
  late TextEditingController titleCtrl;
  late TextEditingController priceCtrl;
  late TextEditingController linkCtrl;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.wish?.title ?? '');
    priceCtrl = TextEditingController(text: widget.wish?.price?.toString() ?? '');
    linkCtrl = TextEditingController(text: widget.wish?.link ?? '');
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    priceCtrl.dispose();
    linkCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.wish == null ? 'Новое желание' : 'Изменить', style: TextStyle(color:CupertinoColors.darkBackgroundGray)),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 400, 
          maxWidth: 500,
          minHeight: 125,
          maxHeight: 150,
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            CupertinoTextField(controller: titleCtrl, placeholder: 'Название'),
            const SizedBox(height: 8),
            CupertinoTextField(controller: priceCtrl, placeholder: 'Цена', keyboardType: TextInputType.number),
            const SizedBox(height: 8),
            CupertinoTextField(controller: linkCtrl, placeholder: 'Ссылка'),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(child: const Text('Отмена'), onPressed: () => Navigator.pop(context)),
        CupertinoDialogAction(
          child: const Text('Сохранить'),
          onPressed: () {
            final title = titleCtrl.text.trim();
            if (title.isEmpty) return;
            final price = double.tryParse(priceCtrl.text);
            final link = linkCtrl.text.isEmpty ? null : linkCtrl.text;
            final wish = Wish(
              title: title,
              price: price,
              link: link,
              categoryId: widget.wish?.categoryId,
              occasionId: widget.wish?.occasionId,
            );
            widget.onSave(wish);
          },
        ),
      ],
    );
  }
}