class AxionVideoPlayer extends ConsumerStatefulWidget {
  final String url;
  final Map<String, String> headers;
  final String title;
  final bool autoPlay;

  const AxionVideoPlayer({
    super.key,
    required this.url,
    required this.headers,
    required this.title,
    this.autoPlay = true,
  });

  @override
  ConsumerState<AxionVideoPlayer> createState() => _AxionVideoPlayerState();
}

class _AxionVideoPlayerState extends ConsumerState<AxionVideoPlayer> {
  late PlayerService _playerService;

  @override
  void initState() {
    super.initState();
    _playerService = createPlayerService();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    await _playerService.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Widget do player
        _playerService.buildPlayerWidget(
          url: widget.url,
          headers: widget.headers,
          autoPlay: widget.autoPlay,
          showControls: true,
        ),

        // Overlay personalizado do Axion TV
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Axion TV',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _playerService.dispose();
    super.dispose();
  }
}