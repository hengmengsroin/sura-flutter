import 'package:flutter/material.dart';

class SuraPaginatedList extends StatefulWidget {
  ///Normal Listview itemCount
  final int itemCount;

  ///Normal Listview physics
  final ScrollPhysics? physics;

  ///Normal Listview scrollDirection
  final Axis scrollDirection;

  ///Normal Listview shrinkWrap
  final bool shrinkWrap;

  ///[SuraPaginatedList] use ListView.separated, so you can provide divider widget
  final Widget? separator;

  ///Normal Listview itemBuilder
  final Widget Function(BuildContext, int) itemBuilder;

  ///Normal Listview padding
  final EdgeInsets padding;

  ///Provider a widget if there's no item
  final Widget? onEmpty;

  ///If [SuraPaginatedList] is user inside another scroll view,
  ///you must provide a [scrollController] that also use in your parent [scrollController] scroll view
  final ScrollController? scrollController;

  ///callback for getting more data when ScrollController reach mex scrolExtends
  final Future<void> Function() dataLoader;

  ///condition to check if we still have more data to fetch
  ///Example: currentItems == totalItems or currentPage == totalPages
  final bool hasMoreData;

  ///widget to show when we're fetching more data
  final Widget? loadingWidget;
  const SuraPaginatedList({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.dataLoader,
    required this.hasMoreData,
    this.physics = const ClampingScrollPhysics(),
    this.shrinkWrap = false,
    this.loadingWidget = const CircularProgressIndicator(),
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    this.scrollDirection = Axis.vertical,
    this.separator,
    this.onEmpty,
    this.scrollController,
  }) : super(key: key);
  @override
  _SuraPaginatedListState createState() => _SuraPaginatedListState();
}

class _SuraPaginatedListState extends State<SuraPaginatedList> {
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
      await widget.dataLoader.call();
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
    return ListView.separated(
      separatorBuilder: (context, index) => widget.separator ?? SizedBox(),
      itemCount: widget.itemCount + 1,
      controller: _isPrimaryScrollView ? scrollController : null,
      padding: widget.padding,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) {
        //check if we reach the end of the list
        if (index == widget.itemCount) {
          //check if we have more data to fetch
          return widget.hasMoreData
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: widget.loadingWidget),
                )
              : const SizedBox();
        }
        return widget.itemBuilder(context, index);
      },
    );
  }
}
