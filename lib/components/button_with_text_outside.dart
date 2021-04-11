import 'package:flutter/material.dart';

enum ButtonWithTextOutsidePosition {
  top,
  bottom,
  left,
  right,
}

class ButtonWithTextOutside extends StatelessWidget {
  final ButtonWithTextOutsidePosition textPosition;
  final String title;
  final IconData icon;
  final void Function() onPressed;

  const ButtonWithTextOutside({
    @required this.textPosition,
    @required this.title,
    @required this.icon,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    switch (textPosition) {
      case ButtonWithTextOutsidePosition.top:
        return Column(
          children: [
            _CustomTitle(
              title: title,
              padding: EdgeInsets.only(right: 8.0),
            ),
            _CustomButton(
              icon: icon,
              onPressed: onPressed,
            ),
          ],
        );
        break;
      case ButtonWithTextOutsidePosition.bottom:
        return Column(
          children: [
            _CustomButton(
              icon: icon,
              onPressed: onPressed,
              padding: EdgeInsets.only(right: 16.0),
            ),
            _CustomTitle(
              title: title,
              padding: EdgeInsets.only(right: 16.0),
            ),
          ],
        );
        break;
      case ButtonWithTextOutsidePosition.right:
        return Row(
          children: [
            _CustomButton(
              icon: icon,
              onPressed: onPressed,
              padding: EdgeInsets.only(left: 16.0),
            ),
            _CustomTitle(
              title: title,
              fontSize: 24,
              padding: EdgeInsets.all(8.0),
            ),
          ],
        );
        break;
      case ButtonWithTextOutsidePosition.left:
        return Row(
          children: [
            _CustomTitle(
              title: title,
              padding: EdgeInsets.only(right: 8.0),
              fontSize: 24,
            ),
            _CustomButton(
              icon: icon,
              onPressed: onPressed,
              padding: EdgeInsets.only(right: 16.0),
            ),
          ],
        );
        break;
      default:
        return null;
    }
  }
}

class _CustomButton extends StatelessWidget {
  final EdgeInsets padding;
  final IconData icon;
  final void Function() onPressed;

  _CustomButton({
    @required this.icon,
    @required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Ink(
        decoration: ShapeDecoration(
          color: Theme.of(context).primaryColor,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(icon),
          color: Colors.white,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _CustomTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final EdgeInsets padding;

  _CustomTitle({
    @required this.title,
    this.fontSize = 16.0,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Schoolbell',
        ),
      ),
    );
  }
}
