import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_maker/features/qr_generator/domain/qr_config_state.dart';
import 'package:qr_maker/features/qr_generator/provider/qr_config_provider.dart';

class QrPreviewSection extends ConsumerWidget {
  const QrPreviewSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(qRConfigProvider);

    return Column(
      children: [
        Expanded(
          child: Center(
            child: config.url.isEmpty
                ? const EmptyQrPlaceholder()
                : QrPreviewWidget(config: config),
          ),
        ),
        const SizedBox(height: 16),
        const QrActionButtons(),
      ],
    );
  }
}

// QR 코드가 없을 때 표시할 플레이스홀더
class EmptyQrPlaceholder extends StatelessWidget {
  const EmptyQrPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code_2,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'URL을 입력하면\nQR 코드가 생성됩니다',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// QR 코드 미리보기 위젯
class QrPreviewWidget extends ConsumerWidget {
  final QRConfigState config;

  const QrPreviewWidget({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: QrImageView(
        data: config.url,
        size: config.size,
        backgroundColor: config.backgroundColor,
        foregroundColor: config.foregroundColor,
        // QR 코드의 error correction level 설정
        errorCorrectionLevel: _getErrorCorrectionLevel(config.errorLevel),
        // 모서리 스타일 설정
        eyeStyle: QrEyeStyle(
          eyeShape: _getEyeShape(config.cornerStyle),
        ),
        // 로고 이미지가 있는 경우 설정
        embeddedImage: config.logoPath != null
            ? AssetImage(config.logoPath!) as ImageProvider
            : null,
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size.square(config.size * config.logoSize),
        ),
      ),
    );
  }

  // QR 코드의 error correction level 변환
  int _getErrorCorrectionLevel(QrErrorLevel level) {
    switch (level) {
      case QrErrorLevel.low:
        return QrErrorCorrectLevel.L;
      case QrErrorLevel.medium:
        return QrErrorCorrectLevel.M;
      case QrErrorLevel.high:
        return QrErrorCorrectLevel.H;
    }
  }

  // QR 코드의 모서리 스타일 변환
  QrEyeShape _getEyeShape(QrCornerStyle style) {
    switch (style) {
      case QrCornerStyle.square:
        return QrEyeShape.square;
      case QrCornerStyle.round:
        return QrEyeShape.circle;
      case QrCornerStyle.dots:
        return QrEyeShape.square; // dots는 기본 지원하지 않아 square로 대체
    }
  }
}

// QR 코드 액션 버튼들
class QrActionButtons extends ConsumerWidget {
  const QrActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasUrl =
        ref.watch(qRConfigProvider.select((value) => value.url.isNotEmpty));

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FilledButton.icon(
          onPressed: hasUrl ? () {/* 복사 구현 */} : null,
          icon: const Icon(Icons.copy),
          label: const Text('복사'),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          onPressed: hasUrl ? () {/* PNG 저장 구현 */} : null,
          icon: const Icon(Icons.download),
          label: const Text('PNG 저장'),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          onPressed: hasUrl ? () {/* SVG 저장 구현 */} : null,
          icon: const Icon(Icons.downloading),
          label: const Text('SVG 저장'),
        ),
      ],
    );
  }
}
