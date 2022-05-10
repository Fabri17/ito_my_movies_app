import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_movies_app/src/constants/assets.dart';
import 'package:my_movies_app/src/constants/colors.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    Key? key,
    required this.padding,
    this.readOnly = false,
    this.onTap,
    this.onChange,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final bool readOnly;
  final Function? onTap;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        // height: 36,
        decoration: BoxDecoration(
          color: colors.kGreyColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              Assets.kIconSearch,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                readOnly: readOnly,
                onTap: () {
                  if (onTap != null) {
                    onTap!.call();
                  }
                },
                onChanged: (value) {
                  if (onChange != null) {
                    onChange!.call(value);
                  }
                },
                style: TextStyle(
                  color: colors.kWhiteColor.withOpacity(0.6),
                  fontSize: 17,
                  letterSpacing: -0.41,
                ),
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  isDense: true,
                  hintStyle: TextStyle(
                    color: colors.kWhiteColor.withOpacity(0.6),
                    fontSize: 17,
                    letterSpacing: -0.41,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
