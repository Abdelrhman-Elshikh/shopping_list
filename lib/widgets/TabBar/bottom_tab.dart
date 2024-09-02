import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'tab_bar_item.dart';
import 'constants.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Tween<double> positionTween;
  late Animation<double> positionAnimation;

  late AnimationController fadeOutController;
  late Animation<double> fadeOutAnimation;
  late Animation<double> fadeInAnimation;

  double iconAlpha = 1;
  IconData nextIcon = Icons.home;
  IconData activeIcon = Icons.home;

  int currentSelected = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupAnimation();
  }

  void setupAnimation() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: ANIM_DURATION));
    fadeOutController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: (ANIM_DURATION ~/ 5)));

    positionTween = Tween<double>(begin: 0, end: 0);
    positionAnimation = positionTween.animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    fadeOutAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: fadeOutController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          iconAlpha = fadeOutAnimation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            activeIcon = nextIcon;
          });
        }
      });

    fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.8, 1, curve: Curves.easeOut)))
      ..addListener(() {
        setState(() {
          iconAlpha = fadeInAnimation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 100,
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: ThemeData().colorScheme.onSurface,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TabBarItem(
                  title: "Add item",
                  iconData: Icons.add,
                  selected: currentSelected == 0,
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.add;
                      currentSelected = 0;
                      context.go('/addItem');
                    });
                    initAnimation(positionAnimation.value, -1);
                  }),
              TabBarItem(
                  title: "HOME",
                  iconData: Icons.home,
                  selected: currentSelected == 1,
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.home;
                      currentSelected = 1;
                      context.go('/');
                    });
                    initAnimation(positionAnimation.value, 0);
                  }),
              TabBarItem(
                  title: "USER",
                  iconData: Icons.person,
                  selected: currentSelected == 2,
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.person;
                      currentSelected = 2;
                    });
                    initAnimation(positionAnimation.value, 1);
                  })
            ],
          ),
        ),
        ignorePointer()
      ],
    );
  }

  initAnimation(double from, double to) {
    positionTween.begin = from;
    positionTween.end = to;
    animationController.reset();
    fadeOutController.reset();
    animationController.forward();
    fadeOutController.forward();
  }

  IgnorePointer ignorePointer() {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Align(
          heightFactor: 1.0,
          alignment: Alignment(positionAnimation.value, 0),
          child: FractionallySizedBox(
            widthFactor: 1 / 3,

            /// 3 because we have 3 icons.
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surface),
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.onPrimary),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Opacity(
                          opacity: iconAlpha,
                          child: Icon(
                            activeIcon,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
