/// Bundled step photos: filename stem must match [assetForStepName] lookup
/// (see `assets/images/`).
String? assetForStepName(String stepName) {
  final k = stepName.trim().toLowerCase();
  const m = {
    'mix flour and water': 'assets/images/mix_flour_water.jpg',
    'rest for autolyse': 'assets/images/rest_autolyse.jpg',
  };
  return m[k];
}
