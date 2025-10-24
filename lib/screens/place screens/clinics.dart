import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_tashkent_client/bloc/addresses/addresses_bloc.dart';
import 'package:go_tashkent_client/screens/company_about.dart';
import 'package:go_tashkent_client/widgets/top_card.dart';
import '../settings.dart';

class Clinics extends StatefulWidget {
  const Clinics({Key? key}) : super(key: key);

  @override
  State<Clinics> createState() => _ClinicsState();
}

class _ClinicsState extends State<Clinics> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchAddresses();

    // search input listener
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _fetchAddresses({String? search}) {
    context.read<AddressesBloc>().add(
      AddressesEvent.addresses(
        categoryId: 1,
        search: search,
      ),
    );
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();
      _fetchAddresses(search: query.isEmpty ? null : query);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: currentindex == 0 ? const Color(0xFFF2F4F5) : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    width: 0.3,
                    color: Colors.black38,
                  ))),
        ),
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          style: TextStyle(color: currentindex == 0 ? Colors.black : Colors.white),
          decoration: InputDecoration(
            hintText: "Qidiruv...".tr(),
            hintStyle: TextStyle(color: currentindex == 0 ? Colors.black38 : Colors.white54),
            border: InputBorder.none,
          ),
        )
            : Text(
          "Клиники и центры диагностики".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            _isSearching ? Icons.close : Icons.arrow_back_rounded,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
          onPressed: () {
            if (_isSearching) {
              _searchController.clear();
              setState(() => _isSearching = false);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: Icon(
                CupertinoIcons.search,
                color: currentindex == 0 ? Colors.black : Colors.white,
              ),
              onPressed: () {
                setState(() => _isSearching = true);
              },
            )
        ],
      ),
      body: BlocBuilder<AddressesBloc, AddressesState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text("⏳ Yuklanmoqda...")),
            loading: () => const Center(child: CupertinoActivityIndicator(radius: 14)),
            failure: (error) => Center(child: Text("${error.message}")),
            success: (data) {
              final addresses = data.data;



              return SingleChildScrollView(
                child: Column(
                  children: addresses.map((item) {
                    return TopCard(
                      name: item.name ?? "",
                      about: item.desc ?? "",
                      latitude: item.latitude ?? "",
                      longitude: item.longitude ?? "",
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
          );
        },
      ),
    );
  }
}
