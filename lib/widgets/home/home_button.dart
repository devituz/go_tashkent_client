import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../screens/settings.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.category,
    required this.description,
    required this.image,
    this.onTap,
  });

  final String category;
  final String description;
  final String image;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
            border: Border.all(
              width: 0.3,
              color: currentindex == 0 ? Colors.black54 : Colors.transparent,
            )),
        child: Stack(
          children: [
            // Текстовая часть
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: currentindex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description.tr(),
                    style: TextStyle(
                      fontSize: 12,
                      color: currentindex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 10,
                        color: Color(0xFFFF7625),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Ташкент'.tr(),
                        style: TextStyle(
                          color:
                              currentindex == 0 ? Colors.black : Colors.white,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.arrow_circle_right,
                        size: 10,
                        color: Color(0xFFFF7625),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Бекабад'.tr(),
                        style: TextStyle(
                          color:
                              currentindex == 0 ? Colors.black : Colors.white,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.arrow_circle_right,
                        size: 10,
                        color: Color(0xFFFF7625),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Ширин'.tr(),
                        style: TextStyle(
                          color:
                              currentindex == 0 ? Colors.black : Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 25,
                    width: size.width / 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF7625),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Заказать'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Изображение в правом нижнем углу
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(0.0), // Отступы от краёв
                child: SizedBox(
                  width: size.width / 2.2, // Размер изображения
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(12)),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain, // Сохранение пропорций
                    ),
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
