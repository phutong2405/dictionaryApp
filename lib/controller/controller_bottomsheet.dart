typedef UpdateOptions = bool Function(dynamic entry);
typedef CloseOptions = bool Function();

class BottomSheetController {
  final CloseOptions closeOptions;
  final UpdateOptions updateOptions;

  const BottomSheetController({
    required this.closeOptions,
    required this.updateOptions,
  });
}
