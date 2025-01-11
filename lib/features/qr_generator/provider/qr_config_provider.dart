import 'package:flutter/material.dart';
import 'package:qr_maker/features/qr_generator/domain/qr_config_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qr_config_provider.g.dart';

@riverpod
class QRConfig extends _$QRConfig {
  @override
  QRConfigState build() {
    return QRConfigState();
  }

  // URL 업데이트
  void updateUrl(String url) {
    state = state.copyWith(url: url);
  }

  // 크기 업데이트
  void updateSize(double size) {
    state = state.copyWith(size: size);
  }

  // 전경색 업데이트
  void updateForegroundColor(Color color) {
    state = state.copyWith(foregroundColor: color);
  }

  // 배경색 업데이트
  void updateBackgroundColor(Color color) {
    state = state.copyWith(backgroundColor: color);
  }

  // 모서리 스타일 업데이트
  void updateCornerStyle(QrCornerStyle style) {
    state = state.copyWith(cornerStyle: style);
  }

  // 로고 업데이트
  void updateLogo(String? path) {
    state = state.copyWith(logoPath: path);
  }

  // 로고 크기 업데이트
  void updateLogoSize(double size) {
    state = state.copyWith(logoSize: size);
  }

  // 에러 수정 레벨 업데이트
  void updateErrorLevel(QrErrorLevel level) {
    state = state.copyWith(errorLevel: level);
  }

  // QR 코드 설정 초기화
  void resetConfig() {
    state = QRConfigState();
  }
}
