import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../bloc/photos/photos_bloc.dart';

class SliderWidgtes extends StatelessWidget {
  const SliderWidgtes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        return state.when(
          initial: () => SizedBox.shrink(),
          loading: () => SizedBox.shrink(),
          success: (photos) {
            final images = photos.data;
            return Center(
              child: SizedBox(
                width: size.width,
                height: size.width / 2.1,
                child: ImageSlideshow(
                  initialPage: Random().nextInt(100),
                  indicatorColor: Colors.transparent,
                  indicatorBackgroundColor: Colors.transparent,
                  autoPlayInterval: 6000,
                  isLoop: true,
                  children: images.map((imgUrl) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:
                        CachedNetworkImage(
                          imageUrl:  imgUrl.image,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },

          failure: (error) => SizedBox.shrink(),
        );
      },
    );
  }
}
