import 'package:cached_network_image/cached_network_image.dart';
import 'package:familylost_faan/ServiciosApp/services/notification_service.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:familylost_faan/ServiciosApp/models/notification.dart'
    as notification;
import 'package:familylost_faan/utilities/paginator/paginator.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_paginator.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Notifications',
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height - 150,
                child: _PaginatedListView(),
              ),
            ),
          ],
        ));
  }
}

class _PaginatedListView<T> extends StatefulWidget {
  const _PaginatedListView({
    Key? key,
  }) : super(key: key);

  @override
  __PaginatedListViewState createState() => __PaginatedListViewState();
}

class __PaginatedListViewState extends State<_PaginatedListView> {
  late Paginator<notification.Notification> _paginator;
  List<notification.Notification> myNotifications = [];

  @override
  void initState() {
    super.initState();
    _initPaginator();
  }

  void _initPaginator() {
    _paginator = Paginator<notification.Notification>(
      fetchPage: (int page) async {
        List<notification.Notification> newPosts;
        newPosts = await NotificationService().getNotificationsByUser(context);
        setState(() {
          myNotifications.addAll(newPosts);
        });
        return newPosts;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  Widget _buildListView() {
    return PaginatedListView<notification.Notification>(
      paginator: _paginator,
      itemBuilder:
          (BuildContext context, notification.Notification notification) {
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
                                  notification.content['author']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Text(
                                '${calculateTimeDifference(notification.createdAt!)}',
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
      },
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
