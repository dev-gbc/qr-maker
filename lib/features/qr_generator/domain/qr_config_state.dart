// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// QR 코드 모서리 스타일
enum QrCornerStyle {
  square, // 각진 모서리
  round, // 둥근 모서리
  dots // 점선 스타일
}

// 에러 수정 레벨
enum QrErrorLevel {
  low, // 낮음 (7%)
  medium, // 중간 (15%)
  high // 높음 (25%)
}

class QRConfigState {
  final String url; // QR 코드에 입력할 URL
  final double size; // QR 코드 크기
  final Color foregroundColor; // QR 코드 색상
  final Color backgroundColor; // 배경 색상
  final QrCornerStyle cornerStyle; // 모서리 스타일
  final String? logoPath; // 로고 이미지 경로
  final double logoSize; // 로고 크기 비율 (0.0 ~ 1.0)
  final QrErrorLevel errorLevel; // 에러 수정 레벨
  QRConfigState({
    this.url = '',
    this.size = 200.0,
    this.foregroundColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.cornerStyle = QrCornerStyle.square,
    this.logoPath,
    this.logoSize = 0.2,
    this.errorLevel = QrErrorLevel.medium,
  });

  QRConfigState copyWith({
    String? url,
    double? size,
    Color? foregroundColor,
    Color? backgroundColor,
    QrCornerStyle? cornerStyle,
    String? logoPath,
    double? logoSize,
    QrErrorLevel? errorLevel,
  }) {
    return QRConfigState(
      url: url ?? this.url,
      size: size ?? this.size,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cornerStyle: cornerStyle ?? this.cornerStyle,
      logoPath: logoPath ?? this.logoPath,
      logoSize: logoSize ?? this.logoSize,
      errorLevel: errorLevel ?? this.errorLevel,
    );
  }
}
