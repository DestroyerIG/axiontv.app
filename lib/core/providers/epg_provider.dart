import 'package:flutter_riverpod/flutter_riverpod.dart';

class EPGProgram {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String? category;
  final String? rating;
  final Map<String, dynamic>? metadata;

  EPGProgram({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.category,
    this.rating,
    this.metadata,
  });

  factory EPGProgram.fromJson(Map<String, dynamic> json) {
    return EPGProgram(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startTime: DateTime.parse(json['start_time'] ?? DateTime.now().toIso8601String()),
      endTime: DateTime.parse(json['end_time'] ?? DateTime.now().toIso8601String()),
      category: json['category'],
      rating: json['rating'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'category': category,
      'rating': rating,
      'metadata': metadata,
    };
  }
}

class EPGChannel {
  final String id;
  final String name;
  final String? logo;
  final List<EPGProgram> programs;

  EPGChannel({
    required this.id,
    required this.name,
    this.logo,
    required this.programs,
  });

  factory EPGChannel.fromJson(Map<String, dynamic> json) {
    return EPGChannel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'],
      programs: (json['programs'] as List<dynamic>?)
          ?.map((e) => EPGProgram.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'programs': programs.map((e) => e.toJson()).toList(),
    };
  }
}

class EPGState {
  final List<EPGChannel> channels;
  final Map<String, List<EPGProgram>> programsByChannel;
  final DateTime currentTime;
  final bool isLoading;
  final String? error;
  final DateTime? lastUpdated;

  EPGState({
    this.channels = const [],
    this.programsByChannel = const {},
    required this.currentTime,
    this.isLoading = false,
    this.error,
    this.lastUpdated,
  });

  EPGState copyWith({
    List<EPGChannel>? channels,
    Map<String, List<EPGProgram>>? programsByChannel,
    DateTime? currentTime,
    bool? isLoading,
    String? error,
    DateTime? lastUpdated,
  }) {
    return EPGState(
      channels: channels ?? this.channels,
      programsByChannel: programsByChannel ?? this.programsByChannel,
      currentTime: currentTime ?? this.currentTime,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class EPGNotifier extends StateNotifier<EPGState> {
  EPGNotifier() : super(EPGState(currentTime: DateTime.now())) {
    _loadSampleData();
  }

  void _loadSampleData() {
    // Dados de exemplo para demonstração
    final samplePrograms = [
      EPGProgram(
        id: '1',
        title: 'Jornal Nacional',
        description: 'Principais notícias do dia',
        startTime: DateTime.now().subtract(const Duration(hours: 1)),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        category: 'Jornalismo',
      ),
      EPGProgram(
        id: '2',
        title: 'Novela das 9',
        description: 'Drama familiar',
        startTime: DateTime.now().add(const Duration(hours: 1)),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        category: 'Novela',
      ),
    ];

    final sampleChannels = [
      EPGChannel(
        id: '1',
        name: 'Globo',
        logo: 'https://sample.com/globo.png',
        programs: samplePrograms,
      ),
    ];

    final programsByChannel = {
      '1': samplePrograms,
    };

    state = state.copyWith(
      channels: sampleChannels,
      programsByChannel: programsByChannel,
      lastUpdated: DateTime.now(),
    );
  }

  Future<void> loadEPG(String url) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simular carregamento de EPG
      await Future.delayed(const Duration(seconds: 2));
      
      // Aqui você implementaria o parsing real do EPG
      // Por enquanto, vamos usar dados de exemplo
      
      state = state.copyWith(
        isLoading: false,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erro ao carregar EPG: ${e.toString()}',
      );
    }
  }

  List<EPGProgram> getCurrentPrograms(String channelId) {
    final programs = state.programsByChannel[channelId] ?? [];
    final now = DateTime.now();
    
    return programs.where((program) {
      return program.startTime.isBefore(now) && program.endTime.isAfter(now);
    }).toList();
  }

  List<EPGProgram> getUpcomingPrograms(String channelId, {int limit = 5}) {
    final programs = state.programsByChannel[channelId] ?? [];
    final now = DateTime.now();
    
    return programs
        .where((program) => program.startTime.isAfter(now))
        .take(limit)
        .toList();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final epgProvider = StateNotifierProvider<EPGNotifier, EPGState>(
  (ref) => EPGNotifier(),
);
