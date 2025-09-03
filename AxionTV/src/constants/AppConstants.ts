export const AppConstants = {
  // Nome da aplicação
  appName: 'Axion TV',
  appVersion: '1.0.0',
  
  // Cores baseadas no 9xtream.net
  colors: {
    // Cores principais
    primary: '#6366F1', // Indigo principal
    secondary: '#8B5CF6', // Violet
    accent: '#F59E0B', // Amber
    success: '#10B981', // Emerald
    warning: '#F59E0B', // Amber
    error: '#EF4444', // Red
    info: '#3B82F6', // Blue
    
    // Cores de fundo (estilo 9xtream)
    background: '#0F0F23', // Azul escuro profundo
    surface: '#1A1B2E', // Azul escuro médio
    card: '#252642', // Azul escuro claro
    surfaceVariant: '#2D2D4A', // Variante de superfície
    
    // Cores de texto
    text: '#FFFFFF', // Branco puro
    textSecondary: '#A1A1AA', // Cinza claro
    textTertiary: '#71717A', // Cinza médio
    textDisabled: '#52525B', // Cinza escuro
    
    // Cores de borda
    border: '#3F3F46', // Cinza escuro
    divider: '#27272A', // Cinza mais escuro
    
    // Cores de gradiente
    gradientStart: '#6366F1',
    gradientEnd: '#8B5CF6',
    gradientAccent: '#F59E0B',
  },
  
  // Espaçamentos
  spacing: {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
    xxxl: 64,
  },
  
  // Bordas (estilo 9xtream)
  borderRadius: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 24,
    round: 50,
    full: 9999,
  },
  
  // Tipografia (estilo 9xtream)
  typography: {
    h1: {
      fontSize: 32,
      fontWeight: '800',
      letterSpacing: -0.5,
    },
    h2: {
      fontSize: 28,
      fontWeight: '700',
      letterSpacing: -0.3,
    },
    h3: {
      fontSize: 24,
      fontWeight: '700',
      letterSpacing: -0.2,
    },
    h4: {
      fontSize: 20,
      fontWeight: '600',
      letterSpacing: -0.1,
    },
    h5: {
      fontSize: 18,
      fontWeight: '600',
    },
    body: {
      fontSize: 16,
      fontWeight: '400',
      lineHeight: 24,
    },
    bodyMedium: {
      fontSize: 16,
      fontWeight: '500',
      lineHeight: 24,
    },
    bodyLarge: {
      fontSize: 18,
      fontWeight: '400',
      lineHeight: 28,
    },
    caption: {
      fontSize: 14,
      fontWeight: '400',
      lineHeight: 20,
    },
    captionMedium: {
      fontSize: 14,
      fontWeight: '500',
      lineHeight: 20,
    },
    button: {
      fontSize: 16,
      fontWeight: '600',
      letterSpacing: 0.1,
    },
    buttonLarge: {
      fontSize: 18,
      fontWeight: '600',
      letterSpacing: 0.1,
    },
    overline: {
      fontSize: 12,
      fontWeight: '500',
      letterSpacing: 0.5,
      textTransform: 'uppercase',
    },
  },
  
  // Configurações do player (estilo 9xtream)
  player: {
    defaultQuality: 'auto',
    autoPlay: true,
    showControls: true,
    showSubtitles: true,
    bufferSize: 15000, // 15 segundos
    seekInterval: 10, // 10 segundos
    volumeStep: 0.1, // 10% por passo
    defaultVolume: 0.8, // 80%
  },
  
  // Configurações de rede
  network: {
    timeout: 30000,
    retryAttempts: 3,
    cacheSize: 200 * 1024 * 1024, // 200MB
    maxConcurrentRequests: 5,
  },
  
  // Configurações de armazenamento
  storage: {
    favoritesKey: 'axion_tv_favorites',
    historyKey: 'axion_tv_history',
    settingsKey: 'axion_tv_settings',
    playlistsKey: 'axion_tv_playlists',
    serversKey: 'axion_tv_servers',
    cacheKey: 'axion_tv_cache',
    userPreferencesKey: 'axion_tv_user_preferences',
  },
  
  // URLs e endpoints
  urls: {
    defaultPlaylist: '',
    epgEndpoint: '',
    supportEmail: 'suporte@axiontv.com',
    website: 'https://axiontv.com',
    apiBase: 'https://api.axiontv.com',
  },
  
  // Configurações de idioma
  supportedLocales: ['pt-BR', 'en-US', 'es-ES'],
  defaultLocale: 'pt-BR',
  
  // Configurações de tema
  themes: {
    light: {
      background: '#FFFFFF',
      surface: '#F8FAFC',
      card: '#FFFFFF',
      text: '#0F172A',
      textSecondary: '#475569',
      border: '#E2E8F0',
    },
    dark: {
      background: '#0F0F23',
      surface: '#1A1B2E',
      card: '#252642',
      text: '#FFFFFF',
      textSecondary: '#A1A1AA',
      border: '#3F3F46',
    },
  },
  
  // Configurações de atualização automática
  autoUpdate: {
    enabled: true,
    interval: 12 * 60 * 60 * 1000, // 12 horas em ms
    checkOnStartup: true,
    showNotifications: true,
  },
  
  // Configurações de cache
  cache: {
    enabled: true,
    maxAge: 24 * 60 * 60 * 1000, // 24 horas
    maxSize: 100 * 1024 * 1024, // 100MB
    cleanupInterval: 60 * 60 * 1000, // 1 hora
  },
  
  // Configurações de qualidade de vídeo
  videoQuality: {
    options: [
      { label: 'Auto', value: 'auto' },
      { label: '1080p', value: '1080' },
      { label: '720p', value: '720' },
      { label: '480p', value: '480' },
      { label: '360p', value: '360' },
    ],
    default: 'auto',
  },
  
  // Configurações de EPG
  epg: {
    enabled: true,
    updateInterval: 60 * 60 * 1000, // 1 hora
    maxDays: 7, // 7 dias de programação
    showCurrentProgram: true,
    showNextProgram: true,
  },
  
  // Configurações de favoritos
  favorites: {
    maxItems: 1000,
    autoSync: true,
    categories: ['Canais', 'Filmes', 'Séries', 'Documentários'],
  },
  
  // Configurações de histórico
  history: {
    maxItems: 500,
    saveProgress: true,
    autoCleanup: true,
    cleanupInterval: 7 * 24 * 60 * 60 * 1000, // 7 dias
  },
  
  // Configurações de busca
  search: {
    minQueryLength: 2,
    maxResults: 100,
    searchIn: ['title', 'description', 'category'],
    recentSearches: 10,
  },
  
  // Configurações de notificações
  notifications: {
    enabled: true,
    types: ['updates', 'favorites', 'errors', 'info'],
    sound: true,
    vibration: true,
  },
  
  // Configurações de controle parental
  parentalControl: {
    enabled: false,
    pin: '0000',
    maxRating: 'PG-13',
    blockCategories: ['Adult', 'Violence'],
    timeRestrictions: {
      enabled: false,
      startTime: '22:00',
      endTime: '06:00',
    },
  },
  
  // Configurações de acessibilidade
  accessibility: {
    highContrast: false,
    largeText: false,
    screenReader: false,
    reducedMotion: false,
  },
};

export default AppConstants;
