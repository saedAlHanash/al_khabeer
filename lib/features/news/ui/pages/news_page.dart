import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:al_khabeer/core/util/snack_bar_message.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/news_cubit/news_cubit.dart';
import '../../data/response/mews_response.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key, this.withAppBar = true});

  final bool withAppBar;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsCubit, NewsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return GridView.builder(
            shrinkWrap: true,
            itemCount: state.result.length,
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0).r,
            itemBuilder: (_, i) => ItemNews(data: state.result[i]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0.h,
              crossAxisSpacing: 10.0.w,
              mainAxisExtent: 200.0.h,
            ),
          );
        },
      ),
    );
  }
}

class ItemNews extends StatelessWidget {
  const ItemNews({Key? key, required this.data}) : super(key: key);

  final NewsData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NoteMessage.showMyDialog(context,
            child: Container(
              color: Colors.white,
              width: 0.9.sw,
              padding: const EdgeInsets.all(20.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: RoundImageWidget(
                      url: data.image,
                      height: 150.0.r,
                      width: 150.0.r,
                    ),
                  ),
                  DrawableText(
                    text: 'عنوان الخبر: ',
                    fontFamily: FontManager.cairoBold.name,
                  ),
                  DrawableText(
                    text: data.title,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    text: ' الخبر: ',
                    fontFamily: FontManager.cairoBold.name,
                  ),
                  DrawableText(
                    text: '${data.note}\n${data.title}',
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                  ),
                ],
              ),
            ));
      },
      child: Column(
        children: [
          RoundImageWidget(
            url: data.image,
            height: 70.0.h,
            width: double.infinity,
          ),
          DrawableText(
            text: data.title,
            maxLines: 3,
            matchParent: true,
            color: AppColorManager.newsHeader,
            size: 20.0.sp,
            padding: const EdgeInsets.symmetric(vertical: 5.0).h,
          ),
          DrawableText(
            text: data.note,
            color: AppColorManager.newsHeader,
            size: 16.0.sp,
            maxLines: 2,
            matchParent: true,
            textAlign: TextAlign.start,
            padding: const EdgeInsets.symmetric(vertical: 5.0).h,
          ),
        ],
      ),
    );
  }
}
