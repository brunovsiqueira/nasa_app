import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/models/rover_photo_item_model.dart';
import 'package:nasa_app/routes.dart';
import 'package:nasa_app/widgets/shimmer_widget.dart';

class RoverItemWidget extends StatelessWidget {
  final RoverPhotoItemModel roverItem;
  const RoverItemWidget({super.key, required this.roverItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Hero(
            tag: 'rover_image${roverItem.id}',
            child: CachedNetworkImage(
              imageUrl: roverItem.imgSrc,
              height: 200,
              fit: BoxFit.fill,
              placeholder: (context, url) => const ShimmerWidget(
                width: 100,
                height: double.infinity,
              ),
              errorWidget: (context, url, error) => Container(),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Center(child: Text('Landed: ${roverItem.rover.landingDate}')),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.roversDetails, arguments: roverItem);
          },
        ),
      ),
    );
  }
}
