import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/src/enums/rover_name_enum.dart';
import 'package:nasa_app/src/errors/failures/base_failure.dart';
import 'package:nasa_app/src/models/rover_photo_item_model.dart';
import 'package:nasa_app/src/providers/rovers_photos_provider.dart';
import 'package:nasa_app/src/widgets/failure_widget.dart';
import 'package:nasa_app/src/widgets/rover_item_widget.dart';

class RoversHomePage extends ConsumerWidget {
  const RoversHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rovers photos'),
          bottom: TabBar(tabs: [
            Tab(text: RoverNameEnum.curiosity.displayName),
            Tab(text: RoverNameEnum.opportunity.displayName),
            Tab(text: RoverNameEnum.spirit.displayName),
          ]),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 61, 145),
        body: TabBarView(
          children: [
            RoversTab(
                asyncResponse:
                    ref.watch(roversPhotosProvider(RoverNameEnum.curiosity))),
            RoversTab(
                asyncResponse:
                    ref.watch(roversPhotosProvider(RoverNameEnum.opportunity))),
            RoversTab(
                asyncResponse:
                    ref.watch(roversPhotosProvider(RoverNameEnum.spirit)))
          ],
        ),
      ),
    );
  }
}

class RoversTab extends ConsumerWidget {
  final AsyncValue<List<RoverPhotoItemModel>> asyncResponse;
  const RoversTab({super.key, required this.asyncResponse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return asyncResponse.when(
      skipLoadingOnRefresh: false,
      data: (photoList) {
        return ListView.builder(
            itemBuilder: (context, index) {
              RoverPhotoItemModel item = photoList[index];

              return RoverItemWidget(roverItem: item);
            },
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
    );
  }
}
