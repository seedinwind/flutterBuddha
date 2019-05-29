import 'package:flutter/material.dart';
import 'dart:async';

typedef Positioned IndicatorContainerBuilder(BuildContext context);

class BannerView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final IndicatorContainerBuilder indicatorBuilder;

  //init index
  final int initIndex;

  //switch interval
  final Duration intervalDuration;

  //animation duration
  final Duration animationDuration;
  final PageController controller;

  //whether cycyle rolling
  final bool cycleRolling;

  //whether auto rolling
  final bool autoRolling;
  final Curve curve;
  final ValueChanged onPageChanged;
  final int itemCount;
  final double height;

  BannerView(
    this.itemBuilder,
    this.indicatorBuilder, {
    Key key,
    this.initIndex = 0,
    this.itemCount = 1,
    this.height = 200,
    this.intervalDuration = const Duration(seconds: 1),
    this.animationDuration = const Duration(milliseconds: 500),
    this.controller,
    this.cycleRolling = false,
    this.autoRolling = true,
    this.curve = Curves.easeInOut,
    this.onPageChanged,
  })  : assert(null != itemBuilder),
        assert(null != indicatorBuilder),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BannerViewState();
  }
}

class _BannerViewState extends State<BannerView> {
  bool _canceledByManual = false;
  Timer _timer;

  Duration _duration;
  PageController _pageController;
  int _currentIndex = 0;

  int _seriesUserScrollRecordCount = 0;

  @override
  void initState() {
    super.initState();
//    _Logger.debug = widget.log ?? true;

    if (widget.cycleRolling) {
      this._currentIndex = widget.initIndex + 1;
    } else {
      this._currentIndex = widget.initIndex;
    }

    this._duration = widget.intervalDuration;
    this._pageController =
        widget.controller ?? PageController(initialPage: this._currentIndex);

    this._nextBannerTask();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NotificationListener(
          child: Container(
            height: widget.height,
            child: _createBanner(),
          ),
          onNotification: (notification) {
            this._handleScrollNotification(notification);
          },
        ),
        widget.indicatorBuilder(context),
      ],
    );
  }

  PageView _createBanner() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return new GestureDetector(
          child: _createBannerItem(context, index),
          onTapDown: (detail) {
            this._cancel(manual: true);
          },
        );
      },
      itemCount: _setItemCount(),
      controller: _pageController,
      onPageChanged: (index) {
//            _Logger.d(TAG, '**********   changed  index: $index  cu: $_currentIndex');
        this._currentIndex = index;
        if (!(this._timer?.isActive ?? false)) {
          this._nextBannerTask();
        }
        setState(() {});
        if (null != widget.onPageChanged) {
          widget.onPageChanged(index);
        }
      },
      physics: new ClampingScrollPhysics(),
    );
  }

  Widget _createBannerItem(context, index) {
    var item;
    if (widget.cycleRolling) {
      if (index == 0) {
        item = widget.itemBuilder(context, widget.itemCount - 1);
      } else if (index == widget.itemCount + 1) {
        item = widget.itemBuilder(context, 0);
      } else {
        item = widget.itemBuilder(context, index);
      }
    } else {
      item = widget.itemBuilder(context, index);
    }
    return item;
  }

  /// [manual] 是否手动停止
  void _cancel({bool manual = false}) {
    _timer?.cancel();
    if (manual) {
      this._canceledByManual = true;
    }
  }

  void _nextBannerTask() {
    if (!mounted) {
      return;
    }

    if (!widget.autoRolling) {
      return;
    }

    this._cancel(manual: false);

    //security check[for fuck the gesture notification handle]
    if (_seriesUserScrollRecordCount != 0) {
      return;
    }
    _timer = new Timer(_duration, () {
      this._doChangeIndex();
    });
  }

  void _doChangeIndex({bool increment = true}) {
    if (!mounted) {
      return;
    }
    this._canceledByManual = false;
    if (increment) {
      this._currentIndex++;
    } else {
      this._currentIndex--;
    }
    this._currentIndex = this._currentIndex % widget.itemCount;
    if (0 == this._currentIndex) {
      this._pageController.jumpToPage(this._currentIndex);
      this._nextBannerTask();
      setState(() {});
    } else {
      _pageController
          .animateToPage(
        this._currentIndex.toInt(),
        duration: widget.animationDuration,
        curve: widget.curve,
      )
          .whenComplete(() {
        if (!mounted) {
          return;
        }

        // _Logger.d(TAG, '=========animationEnd');
        // this._nextBannerTask();
        // setState(() {});
      });
    }
  }

  void _handleScrollNotification(Notification notification) {
    void _resetWhenAtEdge(PageMetrics pm) {
      if (null == pm || !pm.atEdge) {
        return;
      }
      if (!widget.cycleRolling) {
        return;
      }
      try {
        if (this._currentIndex == 0) {
          this._pageController.jumpToPage(this.widget.itemCount - 2);
        } else if (this._currentIndex == this.widget.itemCount - 1) {
          this._pageController.jumpToPage(1);
        }
      } catch (e) {
        print('Exception: ${e?.toString()}');
      }
    }

    void _handleUserScroll(UserScrollNotification notification) {
      UserScrollNotification sn = notification;

      PageMetrics pm = sn.metrics;
      var page = pm.page;
      var depth = sn.depth;

      var left = page == .0 ? .0 : page % (page.round());

      if (_seriesUserScrollRecordCount == 0) {
//        _Logger.d(TAG, '**********   ^^^^  用户手动滑动开始');
        this._cancel(manual: true);
      }
      if (depth == 0) {
//        _Logger.d(TAG, '** countP: $_seriesUserScrollRecordCount  page: $page  , left: $left');

        if (left == 0) {
          if (_seriesUserScrollRecordCount != 0) {
//            _Logger.d(TAG, '**********   ^^^^  用户手动滑动结束, at edge: ${pm.atEdge}');
            setState(() {
              _seriesUserScrollRecordCount = 0;
              _canceledByManual = false;
              _resetWhenAtEdge(pm);
            });
            this._nextBannerTask();
          } else {
            _seriesUserScrollRecordCount++;
          }
        } else {
          _seriesUserScrollRecordCount++;
        }
      }
    }

    void _handleOtherScroll(ScrollUpdateNotification notification) {
      ScrollUpdateNotification sn = notification;
      if (widget.cycleRolling && sn.metrics.atEdge) {
//        _Logger.d(TAG, '>>>   had at edge  $_currentIndex');
        if (this._canceledByManual) {
          return;
        }
        _resetWhenAtEdge(sn.metrics);
      }
    }

    if (notification is UserScrollNotification) {
      _handleUserScroll(notification);
    } else if (notification is ScrollUpdateNotification) {
      _handleOtherScroll(notification);
    }
  }

  int _setItemCount() {
    if (widget.cycleRolling) {
      return widget.itemCount + 2;
    } else {
      return widget.itemCount;
    }
  }
}
