import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget? trailing;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.leading,
    this.trailing,
    required this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      trailing: trailing,
      title: Text(
        title,
        style: titleStyle ??
            const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: subtitleStyle ??
                  const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
            )
          : null,
      onTap: onTap,
    );
  }
}
