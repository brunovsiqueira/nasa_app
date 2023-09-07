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
    return ListTile(
      title: Text(roverItem.rover.name),
      subtitle: Text('Landed: ${roverItem.rover.landingDate}'),
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.roversDetails, arguments: roverItem);
      },
      leading: Hero(
        tag: 'rover_image${roverItem.id}',
        child: CachedNetworkImage(
          imageUrl: roverItem.imgSrc,
          width: 100,
          fit: BoxFit.fill,
          placeholder: (context, url) => const ShimmerWidget(
            width: 100,
            height: double.infinity,
          ),
          errorWidget: (context, url, error) => Container(),
        ),
      ),
    );
  }
}
