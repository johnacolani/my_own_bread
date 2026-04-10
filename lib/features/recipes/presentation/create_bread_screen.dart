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
  final _ingredientsController = TextEditingController(
    text: '500g flour\n350g water\n10g salt\n100g starter',
  );
  final _stepsController = TextEditingController(
    text: 'Mix ingredients\nRest dough\nStretch and fold\nBulk ferment\nShape dough\nFinal proof\nBake',
  );

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _difficultyController.dispose();
    _totalMinutesController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  void _saveBread() {
    if (!_formKey.currentState!.validate()) return;

    final ingredients = _ingredientsController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final steps = _stepsController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final recipe = BreadRecipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      difficulty: _difficultyController.text.trim(),
      totalMinutes: int.tryParse(_totalMinutesController.text.trim()) ?? 0,
      ingredients: ingredients,
      steps: steps,
      isUserCreated: true,
    );

    Navigator.of(context).pop(recipe);
  }

  @override
  Widget build(BuildContext context) {
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
                      label: 'Total minutes',
                      hint: '180',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final parsed = int.tryParse(value ?? '');
                        if (parsed == null || parsed <= 0) {
                          return 'Enter valid minutes';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                hint: 'One step per line',
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter steps';
                  }
                  return null;
                },
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

class _AppField extends StatelessWidget {
  const _AppField({
    required this.controller,
    required this.label,
    required this.hint,
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