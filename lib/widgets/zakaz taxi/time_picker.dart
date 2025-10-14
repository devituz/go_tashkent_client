import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerInput extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;

  /// Новый флаг: если true — без ограничений (весь день), иначе +15 минут от текущего времени
  final bool isTomorrow;

  /// Необязательный фиксированный таймзон-оффсет в часах (например, Ташкент = +5)
  final int? fixedTzOffsetHours;
  const TimePickerInput({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isTomorrow = false,
    this.fixedTzOffsetHours = 5, // дефолт: Ташкент
  });

  @override
  State<TimePickerInput> createState() => _TimePickerInputState();
}

class _TimePickerInputState extends State<TimePickerInput> {
  final TextEditingController _controller = TextEditingController();
  String selectedTime = '';

  Future<void> _selectTime(BuildContext context) async {
    final res = await showCustomCupertinoTimePicker(
      context,
      isTomorrow: widget.isTomorrow,
      fixedTzOffsetHours: widget.fixedTzOffsetHours,
    );
    if (res != null) {
      setState(() {
        selectedTime = res.format(context);
        _controller.text = selectedTime;
      });
    }
  }

  String _getCurrentTimeInGMTPlus5() {
    final base = widget.fixedTzOffsetHours != null
        ? DateTime.now().toUtc().add(
            Duration(hours: widget.fixedTzOffsetHours!),
          )
        : DateTime.now().toLocal();

    final currentTime = base.add(
      const Duration(minutes: 30),
    ); // просто placeholder-хинт
    return '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.tr(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _controller,
          readOnly: true,
          onTap: () => _selectTime(context),
          decoration: InputDecoration(
            hintText: selectedTime.isEmpty
                ? _getCurrentTimeInGMTPlus5()
                : selectedTime,
            filled: true,
            prefixIcon: Icon(widget.icon),
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Future<TimeOfDay?> showCustomCupertinoTimePicker(
    BuildContext context, {
    required bool isTomorrow,
    int? fixedTzOffsetHours,
  }) async {
    // База времени (локальная или фиксированный оффсет — напр. Ташкент +5)
    final DateTime nowBase = fixedTzOffsetHours != null
        ? DateTime.now().toUtc().add(Duration(hours: fixedTzOffsetHours))
        : DateTime.now().toLocal();

    // Если завтра — без ограничений (00:00), иначе минимум = now + 15 мин
    final DateTime minDt = isTomorrow
        ? DateTime(nowBase.year, nowBase.month, nowBase.day, 0, 0)
        : nowBase.add(const Duration(minutes: 15));
    final bool rollsToNextDay = !isTomorrow && minDt.day != nowBase.day;

    int minHour = isTomorrow ? 0 : (rollsToNextDay ? 23 : minDt.hour);
    int minMinute = isTomorrow ? 0 : (rollsToNextDay ? 59 : minDt.minute);

    // Стартовая позиция пикера:
    // завтра — поставим 09:00 (удобная дефолтная точка), сегодня — минимум
    int selectedHour = isTomorrow ? 9 : minHour;
    int selectedMinute = isTomorrow ? 0 : minMinute;

    final hourCtrl = FixedExtentScrollController(initialItem: selectedHour);
    final minuteCtrl = FixedExtentScrollController(initialItem: selectedMinute);

    TimeOfDay clampToMin(int h, int m) {
      if (isTomorrow) return TimeOfDay(hour: h, minute: m); // нет ограничений
      if (h < minHour) return TimeOfDay(hour: minHour, minute: minMinute);
      if (h == minHour && m < minMinute)
        return TimeOfDay(hour: h, minute: minMinute);
      return TimeOfDay(hour: h, minute: m);
    }

    void ensureValidSelection() {
      if (isTomorrow) return;
      final fixed = clampToMin(selectedHour, selectedMinute);
      if (fixed.hour != selectedHour) {
        selectedHour = fixed.hour;
        hourCtrl.animateToItem(
          selectedHour,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      }
      if (fixed.minute != selectedMinute) {
        selectedMinute = fixed.minute;
        minuteCtrl.animateToItem(
          selectedMinute,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      }
    }

    return await showModalBottomSheet<TimeOfDay>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 320,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                "Выберите время".tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (!isTomorrow && rollsToNextDay)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    "Сегодня доступны только ближайшие минуты; выбор завтра недоступен."
                        .tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: hourCtrl,
                        itemExtent: 40,
                        onSelectedItemChanged: (i) {
                          selectedHour = i;
                          if (!isTomorrow) {
                            if (selectedHour < minHour) {
                              selectedHour = minHour;
                              hourCtrl.animateToItem(
                                minHour,
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.easeOut,
                              );
                            }
                            if (selectedHour == minHour &&
                                selectedMinute < minMinute) {
                              selectedMinute = minMinute;
                              minuteCtrl.animateToItem(
                                minMinute,
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.easeOut,
                              );
                            }
                          }
                        },
                        children: List.generate(24, (h) {
                          final disabled = !isTomorrow && h < minHour;
                          return Center(
                            child: Text(
                              h.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: 24,
                                color: disabled ? Colors.grey : Colors.black,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: minuteCtrl,
                        itemExtent: 40,
                        onSelectedItemChanged: (i) {
                          selectedMinute = i;
                          ensureValidSelection();
                        },
                        children: List.generate(60, (m) {
                          final disabled =
                              !isTomorrow &&
                              ((selectedHour < minHour) ||
                                  (selectedHour == minHour && m < minMinute));
                          return Center(
                            child: Text(
                              m.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: 24,
                                color: disabled ? Colors.grey : Colors.black,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                onTap: () {
                  ensureValidSelection();
                  Navigator.pop(
                    context,
                    TimeOfDay(hour: selectedHour, minute: selectedMinute),
                  );
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFFF7625),
                  ),
                  child: Text(
                    "Готово".tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
