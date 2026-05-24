import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../domain/entities/wish.dart';
import '../bloc/wish_bloc.dart';
import '../bloc/wish_event.dart';
import 'wish_dialog.dart';

class WishTile extends StatefulWidget {
  final Wish wish;
  const WishTile({super.key, required this.wish});

  @override
  State<WishTile> createState() => _WishTileState();
}

class _WishTileState extends State<WishTile> with TickerProviderStateMixin {
  late SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
  }

  @override
  void dispose() {
    _slidableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: _slidableController,
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
              padding: EdgeInsets.only(top: 50),
              icon: CupertinoIcons.pencil,
              onPressed: (_) => _showEditDialog(context),
              backgroundColor: Colors.transparent,
          ),
          SlidableAction(
              padding: EdgeInsets.only(top: 50),
              icon: CupertinoIcons.delete,
              backgroundColor: Colors.transparent,
              onPressed: (_) {
                if (widget.wish.id != null) {
                  context.read<WishBloc>().add(DeleteWishEvent(widget.wish.id!));
                }
              },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
        child: GlassContainer(
          height: 70,
          width: 400,
           isFrostedGlass: true,
          frostedOpacity: 0.05,
          blur: 20,
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.25),
              Colors.white.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           borderGradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.60),
              Colors.white.withValues(alpha: 0.0),
              Colors.white.withValues(alpha: 0.0),
              Colors.white.withValues(alpha: 0.60),
            ],
            stops: const [0.0, 0.45, 0.55, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.wish.title, style: const TextStyle(fontSize: 18, color: CupertinoColors.systemMint)),
                const SizedBox(width: 50),
                if (widget.wish.price != null) Text('${widget.wish.price} ₽', style: const TextStyle(color: CupertinoColors.systemGreen)),
              ],
            ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => WishDialog(
        wish: widget.wish,
        onSave: (updatedWish) {
          context.read<WishBloc>().add(UpdateWishEvent(updatedWish.copyWith(id: widget.wish.id)));
          Navigator.pop(context);
        },
      ),
    );
  }
}