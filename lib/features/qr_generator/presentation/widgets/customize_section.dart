// lib/features/qr_generator/presentation/widgets/customize_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_maker/features/qr_generator/domain/qr_config_state.dart';
import 'package:qr_maker/features/qr_generator/provider/qr_config_provider.dart';

class CustomizeSection extends ConsumerWidget {
  const CustomizeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QR 코드 커스터마이즈',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SizeSection(),
          Divider(),
          ColorSection(),
          Divider(),
          CornerStyleSection(),
          Divider(),
          LogoSection(),
          Divider(),
          ErrorCorrectionSection(),
        ],
      ),
    );
  }
}

class SizeSection extends ConsumerWidget {
  const SizeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(qRConfigProvider.select((value) => value.size));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('크기', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: size,
                min: 100,
                max: 300,
                divisions: 20,
                label: '${size.round()}',
                onChanged: (value) {
                  ref.read(qRConfigProvider.notifier).updateSize(value);
                },
              ),
            ),
            const SizedBox(width: 16),
            Text('${size.round()}px'),
          ],
        ),
      ],
    );
  }
}

// 색상 설정 섹션
class ColorSection extends ConsumerWidget {
  const ColorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(qRConfigProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('색상', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ColorPickerButton(
                color: config.foregroundColor,
                onColorChanged: (color) {
                  ref
                      .read(qRConfigProvider.notifier)
                      .updateForegroundColor(color);
                },
                label: 'QR 색상',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ColorPickerButton(
                color: config.backgroundColor,
                onColorChanged: (color) {
                  ref
                      .read(qRConfigProvider.notifier)
                      .updateBackgroundColor(color);
                },
                label: '배경 색상',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// 색상 선택 버튼
class ColorPickerButton extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;
  final String label;

  const ColorPickerButton({
    super.key,
    required this.color,
    required this.onColorChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('$label 선택'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: color,
                    onColorChanged: onColorChanged,
                    pickerAreaHeightPercent: 0.8,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('확인'),
                  ),
                ],
              ),
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

// 모서리 스타일 섹션
class CornerStyleSection extends ConsumerWidget {
  const CornerStyleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style =
        ref.watch(qRConfigProvider.select((value) => value.cornerStyle));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('모서리 스타일', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        SegmentedButton<QrCornerStyle>(
          segments: const [
            ButtonSegment(
              value: QrCornerStyle.square,
              label: Text('각진'),
            ),
            ButtonSegment(
              value: QrCornerStyle.round,
              label: Text('둥근'),
            ),
            ButtonSegment(
              value: QrCornerStyle.dots,
              label: Text('점선'),
            ),
          ],
          selected: {style},
          onSelectionChanged: (Set<QrCornerStyle> selected) {
            ref
                .read(qRConfigProvider.notifier)
                .updateCornerStyle(selected.first);
          },
        ),
      ],
    );
  }
}

// 로고 섹션
class LogoSection extends ConsumerWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(qRConfigProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('로고', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  FilledButton.icon(
                    onPressed: () async {
                      // 로고 이미지 선택 구현
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('로고 선택'),
                  ),
                  if (config.logoPath != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      config.logoPath!.split('/').last,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ],
              ),
            ),
            if (config.logoPath != null) ...[
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  ref.read(qRConfigProvider.notifier).updateLogo(null);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ],
        ),
        if (config.logoPath != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('로고 크기'),
              Expanded(
                child: Slider(
                  value: config.logoSize,
                  min: 0.1,
                  max: 0.3,
                  divisions: 20,
                  label: '${(config.logoSize * 100).round()}%',
                  onChanged: (value) {
                    ref.read(qRConfigProvider.notifier).updateLogoSize(value);
                  },
                ),
              ),
              Text('${(config.logoSize * 100).round()}%'),
            ],
          ),
        ],
      ],
    );
  }
}

// 에러 수정 레벨 섹션
class ErrorCorrectionSection extends ConsumerWidget {
  const ErrorCorrectionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level =
        ref.watch(qRConfigProvider.select((value) => value.errorLevel));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('에러 수정 레벨', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        SegmentedButton<QrErrorLevel>(
          segments: const [
            ButtonSegment(
              value: QrErrorLevel.low,
              label: Text('낮음'),
            ),
            ButtonSegment(
              value: QrErrorLevel.medium,
              label: Text('중간'),
            ),
            ButtonSegment(
              value: QrErrorLevel.high,
              label: Text('높음'),
            ),
          ],
          selected: {level},
          onSelectionChanged: (Set<QrErrorLevel> selected) {
            ref
                .read(qRConfigProvider.notifier)
                .updateErrorLevel(selected.first);
          },
        ),
        const SizedBox(height: 4),
        Text(
          _getErrorLevelDescription(level),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  String _getErrorLevelDescription(QrErrorLevel level) {
    switch (level) {
      case QrErrorLevel.low:
        return '복구 가능한 데이터: 7%';
      case QrErrorLevel.medium:
        return '복구 가능한 데이터: 15%';
      case QrErrorLevel.high:
        return '복구 가능한 데이터: 25%';
    }
  }
}
