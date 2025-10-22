import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_tashkent_client/bloc/order_false/order_false_bloc.dart';

import '../bloc/orders/orders_bloc.dart';
import '../widgets/order_card.dart';
import 'settings.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {


  @override
  void initState() {
    context.read<OrdersBloc>().add(const OrdersEvent.orders(active: true),);
    context.read<OrderFalseBloc>().add(const OrderFalseEvent.orders(active: false),);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          currentindex == 0 ? const Color(0xFFF2F4F5) : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor:
            currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.3,
                color: Colors.black38,
              ),
            ),
          ),
        ),
        title: Text(
          "Мои заказы".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "Активные заказы".tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: currentindex == 0 ? Colors.black : Colors.white,
                ),
              ),
            ),
        BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text("⏳ Yuklanmoqda...")),
              loading: () => Center(
                child: const CupertinoActivityIndicator(
                  radius: 14,
                ),
              ),
              failure: (error) => SizedBox.shrink(),
              success: (orders) {
                if (orders.data == null || orders.data!.isEmpty) {
                  return const Center(child: Text("🟡 Aktiv buyurtmalar yo‘q"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.data!.length,
                  itemBuilder: (context, index) {
                    final order = orders.data![index];

                    // 🔹 Turi (order_type) uchun
                    String getReadableType(String? type) {
                      switch (type) {
                        case 'taxi':
                          return 'TAXI';
                        case 'mail':
                          return 'Pochta';
                        case 'freight_transport':
                          return 'Yuk tashish';
                        default:
                          return 'Noma’lum';
                      }
                    }

                    // 🔹 Manzillar uchun (from_wheres_id, where_tos_id)
                    String getLocationName(int? id) {
                      switch (id) {
                        case 1:
                          return 'Toshkent';
                        case 2:
                          return 'Bekobod';
                        case 3:
                          return 'Shirin';
                        default:
                          return 'Noma’lum joy';
                      }
                    }

                    return OrderCard(
                      type: getReadableType(order.orderType),
                      driver: order.driverName ?? 'Noma’lum',
                      car: order.carName ?? '',
                      licensePlate: order.carNumber ?? '',
                      date: order.createdAt ?? '',
                      from: getLocationName(order.fromWheresId),
                      to: getLocationName(order.whereTosId),
                      price: "${order.price ?? 0}",
                    );
                  },
                );
              },
            );
          },
        ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                "История заказов".tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: currentindex == 0 ? Colors.black : Colors.white,
                ),
              ),
            ),
            BlocBuilder<OrderFalseBloc, OrderFalseState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text("⏳ Yuklanmoqda...")),
                  loading: () => Center(
                    child: const CupertinoActivityIndicator(
                      radius: 14,
                    ),
                  ),
                  failure: (error) => SizedBox.shrink(),
                  success: (orders) {
                    if (orders.data == null || orders.data!.isEmpty) {
                      return const Center(child: Text("🟡 Aktiv buyurtmalar yo‘q"));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.data!.length,
                      itemBuilder: (context, index) {
                        final order = orders.data![index];

                        // 🔹 Turi (order_type) uchun
                        String getReadableType(String? type) {
                          switch (type) {
                            case 'taxi':
                              return 'TAXI';
                            case 'mail':
                              return 'Pochta';
                            case 'freight_transport':
                              return 'Yuk tashish';
                            default:
                              return 'Noma’lum';
                          }
                        }

                        // 🔹 Manzillar uchun (from_wheres_id, where_tos_id)
                        String getLocationName(int? id) {
                          switch (id) {
                            case 1:
                              return 'Bekobod';
                            case 2:
                              return 'Shirin';
                            case 3:
                              return 'Toshkent';
                            default:
                              return 'Noma’lum joy';
                          }
                        }

                        return OrderCard(
                          type: getReadableType(order.orderType),
                          driver: order.driverName ?? 'Noma’lum',
                          car: order.carName ?? '',
                          licensePlate: order.carNumber ?? '',
                          date: order.createdAt ?? '',
                          from: getLocationName(order.fromWheresId),
                          to: getLocationName(order.whereTosId),
                          price: "${order.price ?? 0}",
                        );
                      },
                    );
                  },
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
