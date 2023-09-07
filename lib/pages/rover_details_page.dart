import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/models/rover_photo_item_model.dart';
import 'package:nasa_app/widgets/shimmer_widget.dart';

class RoverDetailsPage extends StatelessWidget {
  const RoverDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item =
        ModalRoute.of(context)!.settings.arguments as RoverPhotoItemModel;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'rover_image${item.id}',
            child: CachedNetworkImage(
              imageUrl: item.imgSrc,
              fit: BoxFit.fill,
              placeholder: (context, url) => const ShimmerWidget(
                width: 100,
                height: double.infinity,
              ),
              errorWidget: (context, url, error) => Container(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      item.rover.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (venue?.shortDescription != null)
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //     child: Text(
          //       venue!.shortDescription!,
          //       style: const TextStyle(fontSize: 16),
          //     ),
          //   ),
          // if (venue?.score != null)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 28.0, left: 16.0),
          //     child: Row(children: [
          //       const Icon(Icons.star),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 8.0),
          //         child: Text('${venue!.score}/10'),
          //       )
          //     ]),
          //   ),
          // if (venue?.distance != null)
          //   ListTile(
          //     title: Text(
          //         '${venue!.distance!} • ${venue.deliveryPrice} • ${venue.estimateRange} min'),
          //   ),
          //TODP: see what makes sense to show
        ],
      ),
    );
  }
}
