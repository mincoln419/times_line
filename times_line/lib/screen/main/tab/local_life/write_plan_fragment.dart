import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:times_line/screen/main/tab/local_life/write_plan_item.dart';

import '../../../../common/widget/w_line.dart';
import '../../fab/w_floating_daangn_button.dart';

class WritePlanFragment extends ConsumerStatefulWidget {
  const WritePlanFragment({super.key});

  @override
  ConsumerState<WritePlanFragment> createState() => _LocalLifeFragmentState();
}

class _LocalLifeFragmentState extends ConsumerState<WritePlanFragment> {
  final scrollController = ScrollController();
  List<TextEditingController> tecList = [];
  @override
  void initState() {
    scrollController.addListener(() {
      final floatingState = ref.read(floatingButtonStateProvider);

      if (scrollController.position.pixels > 100 && !floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(true);
      } else if (scrollController.position.pixels < 100 &&
          floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: '일일계획'.text.make(),
      ),
      body: FutureBuilder(
          future: intList(),
          builder: (context, snapshot) {
            List<int> list = snapshot.data ?? [];
            if (list.isNotEmpty) {
              return ListView.separated(
                padding:
                    const EdgeInsets.only(bottom: FloatingDaangnButton.height),
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return WritePlanItem(index: index, tec: tecList[index]);
                },
                separatorBuilder: (context, index) =>
                    const Line().pSymmetric(h: 15),
                itemCount: list.length,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Future<List<int>> intList() async {
    return await RangeStream(1, 24).map((i) {
      TextEditingController tec = TextEditingController();
      tecList.add(tec);
      return i;
    }).toList();
  }
}
