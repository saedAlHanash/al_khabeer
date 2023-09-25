import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/features/notifications/ui/widget/notifivcation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/notification_count_cubit/notification_count_cubit.dart';
import '../../bloc/notifications_cubit/notifications_cubit.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    AppSharedPreference.clearNotificationCount();
    context.read<NotificationCountCubit>().changeCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: BlocBuilder<NotificationsCubit, NotificationsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return  Expanded(
              child: NotFoundWidget(
                icon: Assets.iconsNoNotifications,
                text: S.of(context).noNotifications,
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.length,
            itemBuilder: (_, i) {
              return NotificationWidget(not: state.result[i]);
            },
          );
        },
      ),
    );
  }
}
