import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../screens/settings.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsForm extends StatelessWidget {
  const NewsForm({
    Key? key,
    required this.text,
    required this.subtext,
    required this.widget,
    required this.createdTime,
    // Новое поле для отображения просмотров
  }) : super(key: key);

  final String text;
  final String subtext;
  final Widget widget;
  final String createdTime;
  // Количество просмотров

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        width: size.width,
        decoration: BoxDecoration(
          color: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: widget,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Html(
                data: text,
                style: {
                  "*": Style(
                    fontFamily: 'PFDinDisplay',
                    fontSize: FontSize(16),
                    color: currentindex == 0 ? Colors.black : Colors.white,
                  ),
                  "strong": Style(fontWeight: FontWeight.bold),
                  "em": Style(fontStyle: FontStyle.italic),
                  "a": Style(color: Colors.blue),
                },
              ),
            ),
            InkWell(
              onTap: () async {
                if (await launchUrlString("https://$subtext",
                    mode: LaunchMode.externalApplication)) {
                } else {
                  await launchUrlString("https://$subtext");
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  subtext,
                  style: const TextStyle(
                    fontFamily: 'PFDinDisplay',
                    fontSize: 16,
                    color: Color(0xFF2081F9),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: currentindex == 0 ? Colors.grey : Colors.white70,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    createdTime,
                    style: TextStyle(
                      fontFamily: 'PFDinDisplay',
                      fontSize: 14,
                      color: currentindex == 0 ? Colors.grey : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
