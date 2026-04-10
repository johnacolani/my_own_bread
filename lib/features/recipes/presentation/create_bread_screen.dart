import 'package:flutter/material.dart';

import '../../../shared/models/bread_recipe.dart';

class CreateBreadScreen extends StatefulWidget {
  const CreateBreadScreen({super.key});

  @override
  State<CreateBreadScreen> createState() => _CreateBreadScreenState();
}

class _CreateBreadScreenState extends State<CreateBreadScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _difficultyController = TextEditingController(text: 'Beginner');
  final _totalMinutesController = TextEditingController(text: '180');
  final _firstProofController = TextEditingController();
  final _secondProofController = TextEditingController();
  final _bakeMinutesController = TextEditingController(text: '35');
  final _bakeTemperatureController = TextEditingController(text: '220');
  final _ingredientsController = TextEditingController(
    text: '500g flour\n350g water\n10g salt\n100g starter',
  );
  final _stepsController = TextEditingController(
    text: 'Mix ingredients | 10\nFirst proof | 60\nShape | 15\nBake | 35',
  );
  final _hydrationController = TextEditingController();
  final _flourTypeController = TextEditingController();
  final _specialInstructionController = TextEditingController();
  final _steamNoteController = TextEditingController();
  final _imageUrlController = TextEditingController();

  BreadType _breadType = BreadType.sourdough;
  LoafCount _loafCount = LoafCount.one;
  LoafSize _loafSize = LoafSize.medium;
  TemperatureUnit _temperatureUnit = TemperatureUnit.celsius;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _difficultyController.dispose();
    _totalMinutesController.dispose();
    _firstProofController.dispose();
    _secondProofController.dispose();
    _bakeMinutesController.dispose();
    _bakeTemperatureController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _hydrationController.dispose();
    _flourTypeController.dispose();
    _specialInstructionController.dispose();
    _steamNoteController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  int? _parseOptionalMinutes(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return null;
    final v = int.tryParse(t);
    if (v == null || v <= 0) return null;
    return v;
  }

  String? _optionalMinutesValidator(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final v = int.tryParse(value.trim());
    if (v == null || v <= 0) return 'Enter minutes or leave empty';
    return null;
  }

  List<RecipeStep> _parseSteps(String text) {
    return text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .map((line) {
          final pipe = line.indexOf('|');
          if (pipe != -1) {
            final name = line.substring(0, pipe).trim();
            final rest = line.substring(pipe + 1).trim();
            final digits = RegExp(r'\d+').firstMatch(rest);
            final m = digits != null ? int.tryParse(digits.group(0)!) : null;
            return RecipeStep(name: name, minutes: m);
          }
          return RecipeStep(name: line);
        })
        .toList();
  }

  String? _trimOrNull(String text) {
    final t = text.trim();
    return t.isEmpty ? null : t;
  }

  void _saveBread() {
    if (!_formKey.currentState!.validate()) return;

    final ingredients = _ingredientsController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final steps = _parseSteps(_stepsController.text);
    if (steps.isEmpty) return;

    final recipe = BreadRecipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      breadType: _breadType,
      difficulty: _difficultyController.text.trim(),
      totalMinutes: int.parse(_totalMinutesController.text.trim()),
      loafCount: _loafCount,
      loafSize: _loafSize,
      firstProofMinutes: _parseOptionalMinutes(_firstProofController.text),
      secondProofMinutes: _parseOptionalMinutes(_secondProofController.text),
      bakeMinutes: int.parse(_bakeMinutesController.text.trim()),
      bakeTemperature: int.parse(_bakeTemperatureController.text.trim()),
      temperatureUnit: _temperatureUnit,
      ingredients: ingredients,
      steps: steps,
      hydrationNote: _trimOrNull(_hydrationController.text),
      flourTypeNote: _trimOrNull(_flourTypeController.text),
      specialInstruction: _trimOrNull(_specialInstructionController.text),
      steamOrDutchOvenNote: _trimOrNull(_steamNoteController.text),
      imageUrl: _trimOrNull(_imageUrlController.text),
      isUserCreated: true,
    );

    Navigator.of(context).pop(recipe);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Bread'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Basics', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              _AppField(
                controller: _titleController,
                label: 'Bread name',
                hint: 'Rustic Sourdough',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter bread name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _AppField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'A soft, homemade loaf with crisp crust.',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _OutlinedDropdown<BreadType>(
                label: 'Bread type',
                value: _breadType,
                items: BreadType.values
                    .map(
                      (t) => DropdownMenuItem(
                        value: t,
                        child: Text(t.label),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _breadType = v);
                },
              ),
              const SizedBox(height: 24),
              Text('Yield & size', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _OutlinedDropdown<LoafCount>(
                      label: 'Makes',
                      value: _loafCount,
                      items: LoafCount.values
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(c.label),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _loafCount = v);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _OutlinedDropdown<LoafSize>(
                      label: 'Loaf size',
                      value: _loafSize,
                      items: LoafSize.values
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text(s.label),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _loafSize = v);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Timing', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _AppField(
                      controller: _difficultyController,
                      label: 'Difficulty',
                      hint: 'Beginner',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter difficulty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AppField(
                      controller: _totalMinutesController,
                      label: 'Total time (min)',
                      hint: '180',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final parsed = int.tryParse(value ?? '');
                        if (parsed == null || parsed <= 0) {
                          return 'Valid minutes';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _AppField(
                      controller: _firstProofController,
                      label: 'First proof (min)',
                      hint: 'Optional',
                      keyboardType: TextInputType.number,
                      validator: _optionalMinutesValidator,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AppField(
                      controller: _secondProofController,
                      label: 'Second proof (min)',
                      hint: 'Optional',
                      keyboardType: TextInputType.number,
                      validator: _optionalMinutesValidator,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _AppField(
                      controller: _bakeMinutesController,
                      label: 'Bake time (min)',
                      hint: '35',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final parsed = int.tryParse(value ?? '');
                        if (parsed == null || parsed <= 0) {
                          return 'Valid minutes';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AppField(
                      controller: _bakeTemperatureController,
                      label: 'Oven temp',
                      hint: '220',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final parsed = int.tryParse(value ?? '');
                        if (parsed == null || parsed <= 0) {
                          return 'Valid temp';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _OutlinedDropdown<TemperatureUnit>(
                      label: 'Unit',
                      value: _temperatureUnit,
                      items: TemperatureUnit.values
                          .map(
                            (u) => DropdownMenuItem(
                              value: u,
                              child: Text(u.shortLabel),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _temperatureUnit = v);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Ingredients & steps', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              _AppField(
                controller: _ingredientsController,
                label: 'Ingredients',
                hint: 'One ingredient per line',
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter ingredients';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _AppField(
                controller: _stepsController,
                label: 'Steps',
                hint: 'One per line. Optional time: Step name | minutes',
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter steps';
                  }
                  if (_parseSteps(value).isEmpty) {
                    return 'Add at least one step';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text('Optional notes', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              _AppField(
                controller: _hydrationController,
                label: 'Hydration note',
                hint: 'e.g. ~70% hydration',
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              _AppField(
                controller: _flourTypeController,
                label: 'Flour type',
                hint: 'e.g. strong bread flour',
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              _AppField(
                controller: _specialInstructionController,
                label: 'Special instruction',
                hint: '',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _AppField(
                controller: _steamNoteController,
                label: 'Steam / Dutch oven',
                hint: 'e.g. steam first 20 min',
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              _AppField(
                controller: _imageUrlController,
                label: 'Image URL (optional)',
                hint: 'https://…',
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _saveBread,
                icon: const Icon(Icons.check),
                label: const Text('Save Bread'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlinedDropdown<T extends Object> extends StatelessWidget {
  const _OutlinedDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        contentPadding: const EdgeInsetsDirectional.only(
          start: 12,
          end: 8,
          top: 4,
          bottom: 4,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          borderRadius: BorderRadius.circular(14),
          value: value,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _AppField extends StatelessWidget {
  const _AppField({
    required this.controller,
    required this.label,
    this.hint = '',
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: maxLines > 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
