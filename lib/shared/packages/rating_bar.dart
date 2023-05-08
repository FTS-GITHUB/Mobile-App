import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Creates rating bar.
///
/// The [onRatingChanged], [filledIcon] & [emptyIcon] must not be null.
class RatingBar extends StatefulWidget {
  /// Default constructor for [RatingBar].
  const RatingBar({
    super.key,
    required this.filledIcon,
    required this.emptyIcon,
    required this.onRatingChanged,
    this.initialRating = 0.0,
    this.maxRating = 5,
    this.alignment = Alignment.center,
    this.direction = Axis.horizontal,
    this.filledColor = const Color(0xFFFFA800),
    this.emptyColor = const Color(0xFFFFA800),
    this.size = 25,
  }) : _readOnly = false;

  /// Creates read only rating bar.
  ///
  /// The [filledIcon] & [emptyIcon] must not be null.
  const RatingBar.readOnly({
    Key? key,
    required this.filledIcon,
    required this.emptyIcon,
    this.maxRating = 5,
    this.alignment = Alignment.centerLeft,
    this.direction = Axis.horizontal,
    this.initialRating = 0.0,
    this.filledColor = const Color(0xFFFFA800),
    this.emptyColor = const Color(0xFFFFA800),
    this.size = 25,
  })  : _readOnly = true,
        onRatingChanged = null,
        super(key: key);

  /// Icon used for filled part of the rating bar.
  final String filledIcon;

  /// Icon used for empty part of the rating bar.
  final String emptyIcon;

  /// Max rating value.
  final int maxRating;

  /// Callback for rating changes.
  final void Function(double)? onRatingChanged;

  /// Initial rating value.
  final double initialRating;

  /// Color used for filled part of the rating bar.
  final Color filledColor;

  /// Color used for empty part of the rating bar.
  final Color emptyColor;

  /// Alignment of the rating bar.
  final Alignment alignment;

  /// Direction of the rating bar.
  final Axis direction;

  /// Size of the rating bar.
  final double size;

  /// If true, the rating bar is read only.
  final bool _readOnly;

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double? _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating.roundToDouble();
  }

  @override
  Widget build(BuildContext context) => _buildRatingBar();

  Widget _buildRatingBar() => Align(
        alignment: widget.alignment,
        child: _buildDirectionWrapper(
          List.generate(
            widget.maxRating,
            (index) {
              final iconPosition = index + 1;
              return _buildIcon(iconPosition);
            },
          ),
        ),
      );

  Widget _buildDirectionWrapper(List<Widget> children) {
    if (widget.direction == Axis.vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildIcon(int position) {
    if (widget._readOnly) return _buildIconView(position);

    return GestureDetector(
      child: _buildIconView(position),
      onTap: () {
        setState(() => _currentRating = position.toDouble());
        final currentRating = _currentRating;
        if (currentRating == null) return;
        widget.onRatingChanged?.call(currentRating);
      },
    );
  }

  Widget _buildIconView(int position) {
    String iconData;
    Color color;
    double rating;

    if (widget._readOnly) {
      rating = widget.initialRating.roundToDouble();
    } else {
      final currentRating = _currentRating;
      if (currentRating == null) throw AssertionError('rating can\'t null');
      rating = currentRating;
    }
    if (position > rating + 0.5) {
      iconData = widget.emptyIcon;
      color = widget.emptyColor;
    } else {
      iconData = widget.filledIcon;
      color = widget.filledColor;
    }
    return Container(
      width: 35,
      height: 35,
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      child: SvgPicture.asset(
        iconData,
        color: color,
        width: 25,
        height: 25,
        fit: BoxFit.contain,
      ),
    );
  }
}
