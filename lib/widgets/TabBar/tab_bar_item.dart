import 'package:flutter/material.dart';
import 'constants.dart';

class TabBarItem extends StatefulWidget {
  String title;
  IconData iconData;
  bool selected;
  Function callbackFunction;

  TabBarItem(
      {super.key,
      required this.title,
      required this.iconData,
      required this.selected,
      required this.callbackFunction});

  @override
  State<TabBarItem> createState() => _TabBarItemState();
}

class _TabBarItemState extends State<TabBarItem> {
  double iconYAlign = ICON_ON;
  double textYAlign = TEXT_OFF;
  double iconAlpha = ALPHA_ON;

  @override
  void initState() {
    super.initState();
    setIconTextAlpha();
  }

  @override
  void didUpdateWidget(covariant TabBarItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setIconTextAlpha();
  }

  setIconTextAlpha() {
    setState(() {
      iconYAlign = (widget.selected) ? ICON_OFF : ICON_ON;
      textYAlign = (widget.selected) ? TEXT_ON : TEXT_OFF;
      iconAlpha = (widget.selected) ? ALPHA_OFF : ALPHA_ON;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: AnimatedAlign(
            duration: const Duration(milliseconds: ANIM_DURATION),
            alignment: Alignment(0, textYAlign),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                // style: TextStyle(fontSize: 28),
                style: ThemeData().textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: AnimatedAlign(
            duration: const Duration(milliseconds: ANIM_DURATION),
            curve: Curves.easeIn,
            alignment: Alignment(0, iconYAlign),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: ANIM_DURATION),
              opacity: iconAlpha,
              child: IconButton(
                icon: Icon(
                  widget.iconData,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  widget.callbackFunction();
                },
              ),
            ),
          ),
        )
      ],
    ));
  }
}
