import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_tashkent_client/bloc/orders/orders_bloc.dart';
import 'package:go_tashkent_client/screens/zakaz/zakaz_taksi.dart';
import 'package:go_tashkent_client/widgets/home/Slider.dart';
import 'package:go_tashkent_client/widgets/order_card_active.dart';
import '../bloc/photos/photos_bloc.dart';
import '../widgets/home/home_button.dart';
import '../widgets/order_card.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  void initState() {
    context.read<OrdersBloc>().add(const OrdersEvent.orders(active: true),);
    context.read<PhotosBloc>().add(const PhotosEvent.photo(photoType: 'photo1'),);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: currentindex == 0
          ? Colors.white
          : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor: currentindex == 0
            ? Colors.white
            : const Color(0xFF43324D),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.3, color: Colors.black38),
            ),
          ),
        ),
        scrolledUnderElevation: 0,
        title: SizedBox(
          width: size.width / 2.2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: currentindex == 0
                ? SvgPicture.asset('assets/icons/logo.svg')
                : SvgPicture.asset('assets/icons/logo dark.svg'),
          ),
        ),
        toolbarHeight: 70,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 16),
            const SliderWidgtes(),
            const SizedBox(height: 16),

            // DRIVER TANLAGANDAN SO'NG
        BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
              failure: (error) => const SizedBox.shrink(),
              success: (orders) {
                final data = orders.data ?? [];
                if (data.isEmpty) {
                  return const SizedBox.shrink();
                }

                final allWaiting = data.every((order) =>
                (order.driverName == null || order.driverName!.trim().isEmpty)
                );

                if (allWaiting) {
                  return const Center(
                    child:  Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16),
                      child: OrderCardActive(),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final order = data[index];

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

                    final hasDriver = (order.driverName ?? '').trim().isNotEmpty;
                    final hasCarName = (order.carName ?? '').trim().isNotEmpty;
                    final hasCarNumber = (order.carNumber ?? '').trim().isNotEmpty;

                    if (!hasDriver || !hasCarName || !hasCarNumber) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: OrderCard(
                        type: getReadableType(order.orderType),
                        driver: order.driverName!,
                        car: order.carName!,
                        licensePlate: order.carNumber!,
                        date: order.createdAt ?? '',
                        from: getLocationName(order.fromWheresId),
                        to: getLocationName(order.whereTosId),
                        price: "${order.price ?? 0}",
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        HomeButton(
              category: 'ТАКСИ',
              description: 'Закажите такси легко!\nВсего в пару кликов!',
              image: 'assets/images/Gentra 2.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ZakazTaxi(),
                  ),
                );
              },

            ),
            HomeButton(
              category: 'ПОЧТОВАЯ ПОСЫЛКА',
              description:
                  'Отправляйте посылки быстро\nи удобно – в любое время!',
              image: 'assets/images/Cobalt 2.png',
              onTap: () {
                Navigator.pushNamed(context, '/current_pochta');
              },
            ),
            HomeButton(
              category: 'ГРУЗОПЕРЕВОЗКИ',
              description: 'Доставка грузов\nбыстро и надежно',
              image: 'assets/images/Labo 2.png',
              onTap: () {
                Navigator.pushNamed(context, '/zakaz_gruz');
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
