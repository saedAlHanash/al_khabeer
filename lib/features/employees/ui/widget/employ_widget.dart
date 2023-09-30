import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/emploees_response.dart';

class EmployWidget extends StatelessWidget {
  const EmployWidget({super.key, required this.data});

  final EmployData data;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      margin: const EdgeInsets.symmetric(vertical: 10.0).h,
      withSideRed: true,
      child: Column(
        children: [
          20.0.verticalSpace,
          CircleImageWidget(
            url: Assets.iconsLogoWithoutText,
            size: 100.0.r,
          ),
          DrawableText(
            drawableAlin: DrawableAlin.between,
            text: data.name,
          ),
          const Divider(endIndent: 0.0),
          DrawableText(
            matchParent: true,
            drawableAlin: DrawableAlin.between,
            text: S.of(context).certificateOrSpecialization,
            drawableEnd: DrawableText(
              text: data.certificateName,
            ),
          ),
          DrawableText(
            matchParent: true,
            drawableAlin: DrawableAlin.between,
            text: S.of(context).administrativePosition,
            drawableEnd: DrawableText(
              text: data.epithet,
            ),
          ),
          DrawableText(
            matchParent: true,
            drawableAlin: DrawableAlin.between,
            text: S.of(context).salaryType,
            drawableEnd: DrawableText(
              text: data.salaryType,
            ),
          ),
          DrawableText(
            matchParent: true,
            drawableAlin: DrawableAlin.between,
            text: S.of(context).employmentDate,
            drawableEnd: DrawableText(
              text: data.dateEmployment?.formatDate ?? '-',
            ),
          ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}
