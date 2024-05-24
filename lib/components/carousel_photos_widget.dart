import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'carousel_photos_model.dart';
export 'carousel_photos_model.dart';

class CarouselPhotosWidget extends StatefulWidget {
  const CarouselPhotosWidget({
    super.key,
    this.parameter1,
  });

  final List<String>? parameter1;

  @override
  State<CarouselPhotosWidget> createState() => _CarouselPhotosWidgetState();
}

class _CarouselPhotosWidgetState extends State<CarouselPhotosWidget> {
  late CarouselPhotosModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarouselPhotosModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final photos = widget.parameter1?.toList() ?? [];
        return Container(
          width: MediaQuery.sizeOf(context).width * 0.48,
          height: 150.0,
          child: CarouselSlider.builder(
            itemCount: photos.length,
            itemBuilder: (context, photosIndex, _) {
              final photosItem = photos[photosIndex];
              return ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  photosItem,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              );
            },
            carouselController: _model.carouselController ??=
                CarouselController(),
            options: CarouselOptions(
              initialPage: max(0, min(1, photos.length - 1)),
              viewportFraction: 1.0,
              disableCenter: true,
              enlargeCenterPage: true,
              enlargeFactor: 1.0,
              enableInfiniteScroll: true,
              scrollDirection: Axis.horizontal,
              autoPlay: false,
              onPageChanged: (index, _) => _model.carouselCurrentIndex = index,
            ),
          ),
        );
      },
    );
  }
}
