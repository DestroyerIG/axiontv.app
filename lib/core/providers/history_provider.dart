import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axion_tv/core/providers/iptv_provider.dart';

class ViewHistory {
  final String channelId;
  final String channelName;
  final String? streamUrl;
  final DateTime viewedAt;
  final Duration? watchDuration;

  ViewHistory({
    required this.channelId,
    required this.channelName,
    this.streamUrl,
    required this.viewedAt,
    this.watchDuration,
  });

  factory ViewHistory.fromJson(Map<String, dynamic> json) {
    return ViewHistory(
      channelId: json['channel_id'] ?? '',
      channelName: json['channel_name'] ?? '',
      streamUrl: json['stream_url'],
      viewedAt: DateTime.parse(json['viewed_at'] ?? DateTime.now().toIso8601String()),
      watchDuration: json['watch_duration'] != null
          ? Duration(seconds: json['watch_duration'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channel_id': channelId,
      'channel_name': channelName,
      'stream_url': streamUrl,
      'viewed_at': viewedAt.toIso8601String(),
      'watch_duration': watchDuration?.inSeconds,
    };
  }
}

class HistoryState {
  final List<ViewHistory> viewHistory;
  final bool isLoading;
  final String? error;

  HistoryState({
    this.viewHistory = const [],
    this.isLoading = false,
    this.error,
  });

  HistoryState copyWith({
    List<ViewHistory>? viewHistory,
    bool? isLoading,
    String? error,
  }) {
    return HistoryState(
      viewHistory: viewHistory ?? this.viewHistory,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HistoryNotifier extends StateNotifier<HistoryState> {
  HistoryNotifier() : super(HistoryState());

  List<ViewHistory> get viewHistory => state.viewHistory;

  void addToHistory(Channel channel) {
    final history = ViewHistory(
      channelId: channel.id,
      channelName: channel.name,
      streamUrl: channel.streamUrl,
      viewedAt: DateTime.now(),
    );

    // Remover se já existe e adicionar no topo
    final updatedHistory = [
      history,
      ...state.viewHistory.where((h) => h.channelId != channel.id),
    ];

    // Manter apenas os últimos 100 itens
    final limitedHistory = updatedHistory.take(100).toList();

    state = state.copyWith(viewHistory: limitedHistory);
  }

  void removeFromHistory(String channelId) {
    final updatedHistory = state.viewHistory
        .where((h) => h.channelId != channelId)
        .toList();
    state = state.copyWith(viewHistory: updatedHistory);
  }

  void clearHistory() {
    state = state.copyWith(viewHistory: []);
  }

  List<ViewHistory> getRecentHistory({int limit = 10}) {
    return state.viewHistory.take(limit).toList();
  }

  List<ViewHistory> getHistoryByChannel(String channelId) {
    return state.viewHistory
        .where((h) => h.channelId == channelId)
        .toList();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final historyProvider = StateNotifierProvider<HistoryNotifier, HistoryState>(
  (ref) => HistoryNotifier(),
);
