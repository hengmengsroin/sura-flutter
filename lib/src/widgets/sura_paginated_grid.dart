import 'package:flutter/material.dart';

import 'spacing.dart';

class SuraPaginatedGridBuilder extends StatefulWidget {
  ///Simple Grid deledate
  final SliverGridDelegate gridDelegate;
  final EdgeInsets padding;
  final int itemCount;
  final bool hasMoreData;
  final Future<void> Function() dataLoader;

  ///If [PaginatedListView] is user inside another scroll view,
  ///you must provide a [scrollController] that also use in your parent [scrollController] scroll view
  final ScrollController? scrollController;

  ///Scroll physic of grid view
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final Widget? loadingWidget;
  final Widget? onEmpty;

  ///Add provided scrollController to our PaginatedListview
  ///Use case: Provided scroll controller usually happen when this ListView is inside another Listview,
  ///So we use provided scrollController to check for paginated trigger only but not attach to PaginatedList
  ///But sometime, provided ScrollController isn't attach to any parent Listview yet. So in that case it must be attach
  ///to our PaginatedList
  final bool attachProvidedScrollControllerToListview;

  ///Indicate if there is an error when getting more data
  final bool hasError;

  ///A widget that show at the bottom of listview when there is an error
  final Widget? errorWidget;

  final Widget Function(BuildContext context, int index) itemBuilder;
  const SuraPaginatedGridBuilder({
    Key? key,
    required this.gridDelegate,
    required this.dataLoader,
    required this.itemCount,
    required this.itemBuilder,
    required this.hasMoreData,
    this.onEmpty,
    this.shrinkWrap = false,
    this.loadingWidget = const CircularProgressIndicator(),
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    this.physics = const ClampingScrollPhysics(),
    this.scrollController,
    this.attachProvidedScrollControllerToListview = false,
    this.hasError = false,
    this.errorWidget,
  }) : super(key: key);
  @override
  _SuraPaginatedGridBuilderState createState() =>
      _SuraPaginatedGridBuilderState();
}

class _SuraPaginatedGridBuilderState extends State<SuraPaginatedGridBuilder> {
  ScrollController? scrollController;
  int loadingState = 0;

  bool get _isPrimaryScrollView => widget.scrollController == null;

  void scrollListener(ScrollController controller) {
    if (controller.offset == controller.position.maxScrollExtent) {
      loadingState += 1;
      onLoadingMoreData();
    }
  }

  void onLoadingMoreData() async {
    if (loadingState > 1) return;
    if (widget.hasMoreData) {
      await widget.dataLoader();
      if (mounted) {
        loadingState = 0;
      }
    }
  }

  void initController() {
    if (_isPrimaryScrollView) {
      scrollController = ScrollController();
      scrollController!.addListener(() => scrollListener(scrollController!));
    } else {
      widget.scrollController
          ?.addListener(() => scrollListener(widget.scrollController!));
    }
  }

  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onEmpty != null && widget.itemCount == 0) {
      return widget.onEmpty!;
    }
    return Column(
      children: [
        Expanded(
          flex: _isPrimaryScrollView ? 1 : 0,
          child: GridView.builder(
            gridDelegate: widget.gridDelegate,
            shrinkWrap: widget.shrinkWrap,
            padding: widget.padding,
            controller: _isPrimaryScrollView
                ? scrollController
                : widget.attachProvidedScrollControllerToListview
                    ? widget.scrollController
                    : null,
            physics: widget.physics,
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder,
          ),
        ),
        _buildBottomLoadingWidget(),
      ],
    );
  }

  Widget _buildBottomLoadingWidget() {
    if (widget.hasError) {
      return widget.errorWidget ??
          IconButton(
            onPressed: () => widget.dataLoader(),
            icon: const Icon(Icons.refresh),
          );
    }
    return widget.hasMoreData
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: widget.loadingWidget),
          )
        : emptySizedBox;
  }
}
