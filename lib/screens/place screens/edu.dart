import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_tashkent_client/bloc/addresses/addresses_bloc.dart';

import '../../widgets/card_company.dart';
import '../../widgets/top_card.dart';
import '../company_about.dart';
import '../settings.dart';

class EduPage extends StatefulWidget {
  const EduPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EduPage> createState() => _EduPageState();
}

class _EduPageState extends State<EduPage> {

  @override
  void initState() {
    super.initState();
    context.read<AddressesBloc>().add(
      AddressesEvent.addresses(
        categoryId: 4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          ))),
        ),
        title: Text(
          "Университеты и институты".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.search,
                  color: currentindex == 0 ? Colors.black : Colors.white,
                )),
          )
        ],
      ),
      body: BlocBuilder<AddressesBloc, AddressesState>(
        builder: (context, state) {
          return state.when(
              initial: () => const Center(child: Text("⏳ Yuklanmoqda...")),
              loading: () => Center(
                child: const CupertinoActivityIndicator(
                  radius: 14,
                ),
              ),

              success: (data) {
                final addresses = data.data ?? [];

                if (addresses.isEmpty) {
                  return const Center(child: Text("Hech narsa topilmadi"));
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: addresses.map((item) {
                      return TopCard(
                        name: item.name ?? "",
                        about: item.desc ?? "",
                        latitude: item.latitude ?? "",
                        longitude:item.longitude ?? "",
                        top_obloshka: item.topObloshka ?? "",
                        logo: item.logo ?? "",
                        adres: item.address ?? "",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutCompany(item: item),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },

              /// ❌ Xatolik holati
              failure: (error) => SizedBox.shrink()
          );
        },
      ),
    );
  }
}
