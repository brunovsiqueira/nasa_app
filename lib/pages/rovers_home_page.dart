import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/enums/rover_name_enum.dart';
import 'package:nasa_app/errors/failures/base_failure.dart';
import 'package:nasa_app/models/rover_photo_item_model.dart';
import 'package:nasa_app/providers/rovers_photos_provider.dart';
import 'package:nasa_app/widgets/failure_widget.dart';
import 'package:nasa_app/widgets/rover_item_widget.dart';

class RoversHomePage extends ConsumerWidget {
  const RoversHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<RoverPhotoItemModel>> asyncResponse =
        ref.watch(roversPhotosProvider(RoverNameEnum.curiosity));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rovers photos'),
      ),
      body: asyncResponse.when(
        skipLoadingOnRefresh: false,
        data: (photoList) {
          return ListView.separated(
              itemBuilder: (context, index) {
                RoverPhotoItemModel item = photoList[index];

                return RoverItemWidget(roverItem: item);
              },
              separatorBuilder: (_, __) => const Divider(height: 0.5),
              itemCount: photoList.length);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          return FailureWidget(
            failure: error as BaseFailure,
            refreshCallback: () {
              ref.invalidate(roversPhotosProvider(RoverNameEnum.curiosity));
            },
          );
        },
      ),
    );
  }
}
