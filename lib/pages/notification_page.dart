import 'package:cached_network_image/cached_network_image.dart';
import 'package:familylost_faan/ServiciosApp/dto/notification_response.dart';
import 'package:familylost_faan/ServiciosApp/services/notification_service.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<NotificationPageProvider>(context, listen: false);
    provider.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationPageProvider>(context);
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryMainColor,
        title: Text(
          'Notifications',
          style: AppFonts.TitlePost,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: AppColors.icnColor,
        ),
      ),
      body: Container(
        child:
            provider.result.length == 0 ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/no_notifications.png',
                    height: _deviceHeight * 0.3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'No notifications yet',
                    style: AppFonts.TitlePost,
                  ),
                ],
              ),
            ) :

        ListView.builder(
          itemCount: provider.result.length,
          itemBuilder: (context, index) {
            return _listItemView(
              provider.result[index],
            );
          },
        ),
      ),
    );
  }

  Widget _listItemView(
    NotificationResponse notification,
  ) {
    return GestureDetector(
      onTap: () {
        //Add the detail of Post from notification tap
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.secondaryMainColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.icnColor.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    notification.imageUrl,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.author,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Text(
                            '${calculateTimeDifference(notification.createdAt)}',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      Text(
                        notification.title,
                        style: const TextStyle(
                          color: AppColors.msgDialogColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String calculateTimeDifference(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return '${difference.inSeconds} seconds ago';
    }
  }
}
