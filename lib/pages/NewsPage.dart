import 'package:festapp/data/OfflineDataHelper.dart';
import 'package:festapp/RouterService.dart';
import 'package:festapp/data/RightsHelper.dart';
import 'package:festapp/services/ToastHelper.dart';
import 'package:festapp/styles/Styles.dart';
import 'package:festapp/appConfig.dart';
import 'package:festapp/widgets/HtmlView.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import '../models/NewsModel.dart';
import '../data/DataService.dart';
import 'HtmlEditorPage.dart';

class NewsPage extends StatefulWidget {
  static const ROUTE = "news";
  const NewsPage({Key? key}) : super(key: key);
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsModel> newsMessages = [];

  void _showMessageDialog(BuildContext context, [bool withNotification = true]) {
    if(!AppConfig.isNotificationsSupported && withNotification)
    {
      ToastHelper.Show("Notifications are not supported. Send message without notification.".tr(), severity: ToastSeverity.NotOk);
      return;
    }
    RouterService.navigate(context, HtmlEditorPage.ROUTE).then((value) async {
      if(value != null)
      {
        var message = value as String;
        await DataService.insertNewsMessage(message, withNotification);
        await loadNewsMessages();
      }
    });
  }

  Future<void> loadNewsMessages() async {
    var loadedMessages = await DataService.getAllNewsMessages();
    setState(() {
      newsMessages = loadedMessages;
    });
    if(DataService.isLoggedIn() && newsMessages.isNotEmpty)
    {
      DataService.setMessagesAsRead(newsMessages.first.id);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    newsMessages = OfflineDataHelper.getAllMessages();
    loadNewsMessages();
    OfflineDataHelper.saveAllMessages(newsMessages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News").tr(),
        leading: BackButton(
          onPressed: () => RouterService.goBackOrHome(context),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: appMaxWidth),
          child: ListView.builder(
            itemCount: newsMessages.length,
            itemBuilder: (BuildContext context, int index) {
              final message = newsMessages[index];
              final previousMessage = index > 0 ? newsMessages[index - 1] : null;

              final isSameDay = previousMessage != null &&
                  message.createdAt!.year == previousMessage.createdAt!.year &&
                  message.createdAt!.month == previousMessage.createdAt!.month &&
                  message.createdAt!.day == previousMessage.createdAt!.day;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (index != 0 && !isSameDay)
                    const Divider(),
                  if (index == 0 || !isSameDay)
                    Container(
                      padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
                      alignment: Alignment.topRight,
                      child: Text(
                        DateFormat("EEEE d.M.y", context.locale.languageCode).format(message.createdAt!),
                        style: message.isRead?readTextStyle:unReadTextStyle,
                      ),
                    ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(message.createdBy??"", style: message.isRead?readTextStyle:unReadTextStyle,)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppConfig.color1.withOpacity(0.10)
                      ),
                      child: Column(
                        children: [
                          Padding(padding: const EdgeInsets.all(16), child: HtmlView(html: message.message!)),
                          Visibility(
                            visible: DataService.isLoggedIn(),
                            child: Padding(padding: const EdgeInsets.all(8), child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [const Icon(Icons.remove_red_eye, size: 16, color: Colors.black54,), const SizedBox(width: 6), Text(message.views.toString(), style: readTextStyle,), const SizedBox(width: 10),],)))
                        ],
                      ),
                    )),
                  Visibility(
                    visible: RightsHelper.isEditor(),
                    child: PopupMenuButton<ContextMenuChoice>(
                      onSelected: (choice) async {
                        if(choice == ContextMenuChoice.delete)
                        {
                          await DataService.deleteNewsMessage(message);
                        }
                        else{
                          RouterService.navigate(context, HtmlEditorPage.ROUTE, extra: message.message).then((value) async {
                            if(value != null)
                            {
                              var newMessage = value as String;
                              message.message = newMessage;
                              await DataService.updateNewsMessage(message);
                              RouterService.pushReplacement(context, NewsPage.ROUTE);
                            }
                          });
                        }
                        loadNewsMessages();
                      },
                      icon:  const Icon(Icons.more_horiz),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<ContextMenuChoice>>[
                        PopupMenuItem<ContextMenuChoice>(
                        value: ContextMenuChoice.edit,
                        child: const Text("Edit").tr(),
                        ),
                        PopupMenuItem<ContextMenuChoice>(
                          value: ContextMenuChoice.delete,
                          child: const Text("Delete").tr(),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: RightsHelper.isEditor(),
        child: SpeedDial(
          direction: SpeedDialDirection.up,
          spaceBetweenChildren: 20,
          children: [
            SpeedDialChild(child: const Icon(Icons.notifications_off), label: "Send without notification".tr(), onTap: () => _showMessageDialog(context, false)),
            SpeedDialChild(child: const Icon(Icons.message), label: "Send message".tr(), onTap: () => _showMessageDialog(context)),
          ],
          icon: Icons.add,
        ),
      ),
    );
  }
  TextStyle unReadTextStyle = const TextStyle(fontWeight: FontWeight.bold);
  TextStyle readTextStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54);

}

enum ContextMenuChoice { delete, edit }