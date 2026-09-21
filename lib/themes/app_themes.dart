import 'package:flutter/material.dart';

/// A theme definition for The Bounty Board.
class AppTheme {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final Color seedColor;
  final Color? surfaceColor;
  final Brightness brightness;

  const AppTheme({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.seedColor,
    this.surfaceColor,
    required this.brightness,
  });

  ThemeData get themeData {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
      surface: surfaceColor,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
    );
  }
}

/// All available themes for The Bounty Board.
const List<AppTheme> appThemes = [
  // ── Default ────────────────────────────────────────────
  AppTheme(
    id: 'midnight',
    name: 'Midnight Bounty',
    emoji: '🌙',
    description: 'Dark purple — bounty hunter vibes',
    seedColor: Color(0xFF6750A4),
    surfaceColor: Color(0xFF12101F),
    brightness: Brightness.dark,
  ),
  // ── Anime: Naruto ───────────────────────────────────────
  AppTheme(
    id: 'naruto',
    name: 'Ninja Scroll 巻物',
    emoji: '🍥',
    description: 'Blazing orange — shinobi spirit',
    seedColor: Color(0xFFFF6B00),
    surfaceColor: Color(0xFF1A0F00),
    brightness: Brightness.dark,
  ),
  // ── Anime: Demon Slayer ─────────────────────────────────
  AppTheme(
    id: 'demonslayer',
    name: 'Demon Slayer 鬼滅',
    emoji: '⚔️',
    description: 'Crimson flames — Tanjiro\'s resolve',
    seedColor: Color(0xFFDC143C),
    surfaceColor: Color(0xFF140018),
    brightness: Brightness.dark,
  ),
  // ── Anime: Jujutsu Kaisen ───────────────────────────────
  AppTheme(
    id: 'jjk',
    name: 'Cursed Energy 呪力',
    emoji: '👁️',
    description: 'Deep navy — Gojo\'s infinite void',
    seedColor: Color(0xFF7B2FBE),
    surfaceColor: Color(0xFF0A0A1A),
    brightness: Brightness.dark,
  ),
  // ── Anime: One Piece ────────────────────────────────────
  AppTheme(
    id: 'onepiece',
    name: 'Pirate King 海賊王',
    emoji: '☠️',
    description: 'Gold & ocean blue — King of the Pirates',
    seedColor: Color(0xFFFFD700),
    surfaceColor: Color(0xFF001A30),
    brightness: Brightness.dark,
  ),
  // ── Japanese: Sakura ────────────────────────────────────
  AppTheme(
    id: 'sakura',
    name: 'Sakura 桜',
    emoji: '🌸',
    description: 'Cherry blossom pink — spring elegance',
    seedColor: Color(0xFFE91E8C),
    surfaceColor: Color(0xFFFFF5F9),
    brightness: Brightness.light,
  ),
  // ── Japanese: Samurai ───────────────────────────────────
  AppTheme(
    id: 'samurai',
    name: 'Bushido 武士道',
    emoji: '🗡️',
    description: 'Gold & crimson — the warrior\'s code',
    seedColor: Color(0xFFB8860B),
    surfaceColor: Color(0xFF0F0A00),
    brightness: Brightness.dark,
  ),
  // ── Japanese: Tokyo Neon ────────────────────────────────
  AppTheme(
    id: 'tokyoneon',
    name: 'Tokyo Neon 東京',
    emoji: '🌆',
    description: 'Cyberpunk cyan — neon streets of Tokyo',
    seedColor: Color(0xFF00BCD4),
    surfaceColor: Color(0xFF050510),
    brightness: Brightness.dark,
  ),
  // ── Japanese: Forest Spirit ─────────────────────────────
  AppTheme(
    id: 'forest',
    name: 'Forest Spirit 森',
    emoji: '🌿',
    description: 'Soft greens — Ghibli\'s nature magic',
    seedColor: Color(0xFF2E7D32),
    surfaceColor: Color(0xFFF1F8E9),
    brightness: Brightness.light,
  ),
  // ── Light: Ink Wash ─────────────────────────────────────
  AppTheme(
    id: 'inkwash',
    name: 'Ink Wash 水墨',
    emoji: '🖌️',
    description: 'Classic sumi-e — black ink on white',
    seedColor: Color(0xFF37474F),
    surfaceColor: Color(0xFFFAFAFA),
    brightness: Brightness.light,
  ),
];
