// Tipos para servidores IPTV
export interface XtreamServer {
  id: string;
  name: string;
  url: string;
  username: string;
  password: string;
  type: 'xtream';
  lastUpdated: Date;
  isActive: boolean;
}

export interface M3UServer {
  id: string;
  name: string;
  url: string;
  type: 'm3u';
  lastUpdated: Date;
  isActive: boolean;
}

export type Server = XtreamServer | M3UServer;

// Tipos para canais IPTV
export interface Channel {
  id: string;
  name: string;
  logo?: string;
  streamUrl: string;
  category?: string;
  language?: string;
  country?: string;
  isHD?: boolean;
  isFavorite?: boolean;
  lastWatched?: Date;
  serverId: string;
  streamType: 'live' | 'movie' | 'series';
}

// Tipos para filmes
export interface Movie {
  id: string;
  name: string;
  originalName?: string;
  description?: string;
  poster?: string;
  backdrop?: string;
  year?: number;
  duration?: number; // em minutos
  rating?: number;
  genre?: string[];
  director?: string;
  cast?: string[];
  streamUrl: string;
  serverId: string;
  isFavorite?: boolean;
  lastWatched?: Date;
}

// Tipos para séries
export interface Series {
  id: string;
  name: string;
  originalName?: string;
  description?: string;
  poster?: string;
  backdrop?: string;
  year?: number;
  genre?: string[];
  seasons: Season[];
  serverId: string;
  isFavorite?: boolean;
  lastWatched?: Date;
}

export interface Season {
  id: string;
  number: number;
  name?: string;
  episodes: Episode[];
}

export interface Episode {
  id: string;
  number: number;
  name: string;
  description?: string;
  poster?: string;
  streamUrl: string;
  duration?: number;
  isWatched?: boolean;
  lastWatched?: Date;
}

// Tipos para categorias
export interface Category {
  id: string;
  name: string;
  icon?: string;
  color?: string;
  itemCount: number;
}

// Tipos para playlists
export interface Playlist {
  id: string;
  name: string;
  server: Server;
  channels: Channel[];
  movies: Movie[];
  series: Series[];
  categories: Category[];
  lastUpdated: Date;
  nextUpdate: Date; // próxima atualização (12 em 12 horas)
}

// Tipos para EPG (Guia de Programação)
export interface EPGProgram {
  id: string;
  title: string;
  description?: string;
  startTime: Date;
  endTime: Date;
  category?: string;
  rating?: string;
  channelId: string;
}

export interface EPGChannel {
  id: string;
  name: string;
  programs: EPGProgram[];
}

// Tipos para favoritos
export interface Favorite {
  id: string;
  itemId: string;
  itemType: 'channel' | 'movie' | 'series';
  name: string;
  streamUrl?: string;
  addedAt: Date;
}

// Tipos para histórico
export interface HistoryItem {
  id: string;
  itemId: string;
  itemType: 'channel' | 'movie' | 'series';
  name: string;
  streamUrl: string;
  watchedAt: Date;
  duration: number; // em segundos
  progress?: number; // progresso da reprodução (0-100)
}

// Tipos para configurações
export interface AppSettings {
  theme: 'light' | 'dark' | 'system';
  language: string;
  autoPlay: boolean;
  defaultQuality: string;
  showSubtitles: boolean;
  parentalControl: boolean;
  notifications: boolean;
  autoUpdate: boolean;
  updateInterval: number; // em horas (padrão: 12)
  defaultServer?: string;
  autoRefreshPlaylists: boolean;
}

// Tipos para autenticação
export interface User {
  id: string;
  username: string;
  email?: string;
  isPremium: boolean;
  createdAt: Date;
  lastLogin: Date;
  servers: Server[];
}

export interface AuthState {
  isAuthenticated: boolean;
  user: User | null;
  isLoading: boolean;
  error: string | null;
}

// Tipos para navegação
export type RootStackParamList = {
  Splash: undefined;
  Onboarding: undefined;
  Login: undefined;
  Home: undefined;
  Player: {
    itemId: string;
    itemType: 'channel' | 'movie' | 'series';
    itemName: string;
    streamUrl: string;
  };
  Channels: undefined;
  Movies: undefined;
  Series: undefined;
  Favorites: undefined;
  Search: undefined;
  Settings: undefined;
  ServerSetup: undefined;
};

export type HomeTabParamList = {
  Live: undefined;
  Movies: undefined;
  Series: undefined;
  Favorites: undefined;
  Settings: undefined;
};

// Tipos para o player
export interface PlayerState {
  isPlaying: boolean;
  isBuffering: boolean;
  currentTime: number;
  duration: number;
  quality: string;
  volume: number;
  isFullscreen: boolean;
  showControls: boolean;
  error: string | null;
  currentItem?: {
    id: string;
    type: 'channel' | 'movie' | 'series';
    name: string;
  };
}

// Tipos para busca
export interface SearchResult {
  channels: Channel[];
  movies: Movie[];
  series: Series[];
  categories: string[];
  totalResults: number;
}

// Tipos para notificações
export interface Notification {
  id: string;
  title: string;
  message: string;
  type: 'info' | 'success' | 'warning' | 'error';
  timestamp: Date;
  isRead: boolean;
}

// Tipos para estatísticas
export interface ViewingStats {
  totalWatchTime: number; // em segundos
  favoriteChannels: string[];
  favoriteMovies: string[];
  favoriteSeries: string[];
  mostWatchedCategories: string[];
  averageSessionDuration: number;
  lastWeekActivity: {
    date: string;
    watchTime: number;
  }[];
}

// Tipos para atualizações
export interface AppUpdate {
  version: string;
  isAvailable: boolean;
  isRequired: boolean;
  releaseNotes: string;
  downloadUrl: string;
  size: number;
}

// Tipos para erros
export interface AppError {
  code: string;
  message: string;
  details?: any;
  timestamp: Date;
}

// Tipos para respostas da API
export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
}

// Tipos para cache
export interface CacheItem<T> {
  key: string;
  data: T;
  timestamp: Date;
  expiresAt: Date;
}

// Tipos para permissões
export interface Permission {
  name: string;
  isGranted: boolean;
  isRequired: boolean;
  description: string;
}

// Tipos para dispositivos
export interface DeviceInfo {
  platform: 'ios' | 'android' | 'web';
  version: string;
  model: string;
  isTV: boolean;
  screenSize: {
    width: number;
    height: number;
  };
  orientation: 'portrait' | 'landscape';
}

// Tipos para sincronização
export interface SyncStatus {
  lastSync: Date;
  nextSync: Date;
  isSyncing: boolean;
  progress: number; // 0-100
  error?: string;
}

// Tipos para qualidade de stream
export interface StreamQuality {
  label: string;
  value: string;
  bitrate?: number;
  resolution?: string;
}
