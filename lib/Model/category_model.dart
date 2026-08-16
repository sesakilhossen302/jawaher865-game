import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String title;
  final String? imagePath;
  final String? iconUrl;
  final IconData? iconData;
  final Color? iconColor;
  final bool isSelected;

  CategoryModel({
    required this.id,
    required this.title,
    this.imagePath,
    this.iconUrl,
    this.iconData,
    this.iconColor,
    this.isSelected = false,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] ?? json['name'] ?? '',
      imagePath: json['image_path'] ?? json['image'],
      iconUrl: json['icon_url'] ?? json['icon'],
      isSelected: json['is_selected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_path': imagePath,
      'icon_url': iconUrl,
      'is_selected': isSelected,
    };
  }

  CategoryModel copyWith({
    int? id,
    String? title,
    String? imagePath,
    String? iconUrl,
    IconData? iconData,
    Color? iconColor,
    bool? isSelected,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      iconUrl: iconUrl ?? this.iconUrl,
      iconData: iconData ?? this.iconData,
      iconColor: iconColor ?? this.iconColor,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
