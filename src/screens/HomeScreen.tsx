import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  StatusBar,
  Dimensions,
} from 'react-native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { useTheme } from '../contexts/ThemeContext';
import { useAuth } from '../contexts/AuthContext';
import AppConstants from '../constants/AppConstants';

const { width } = Dimensions.get('window');
const Tab = createBottomTabNavigator();

// Tela de Canais ao Vivo
const LiveChannelsScreen: React.FC = () => {
  const { colors } = useTheme();
  
  return (
    <ScrollView style={[styles.container, { backgroundColor: colors.background }]}>
      <StatusBar barStyle="light-content" backgroundColor={colors.background} />
      
      {/* Header */}
      <View style={styles.header}>
        <Text style={[styles.title, { color: colors.text }]}>📺 Canais ao Vivo</Text>
        <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
          Assista seus canais favoritos em tempo real
        </Text>
      </View>

      {/* Categorias de Canais */}
      <View style={styles.section}>
        <Text style={[styles.sectionTitle, { color: colors.text }]}>Categorias</Text>
        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          {['Todos', 'Esportes', 'Notícias', 'Filmes', 'Séries', 'Infantil', 'Documentários'].map((category, index) => (
            <TouchableOpacity
              key={index}
              style={[styles.categoryChip, { backgroundColor: colors.surface }]}
            >
              <Text style={[styles.categoryText, { color: colors.text }]}>{category}</Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      {/* Canais em Destaque */}
      <View style={styles.section}>
        <Text style={[styles.sectionTitle, { color: colors.text }]}>Em Destaque</Text>
        <View style={styles.channelGrid}>
          {[1, 2, 3, 4, 5, 6].map((item) => (
            <TouchableOpacity
              key={item}
              style={[styles.channelCard, { backgroundColor: colors.surface }]}
            >
              <View style={[styles.channelLogo, { backgroundColor: colors.primary }]}>
                <Text style={styles.channelLogoText}>📺</Text>
              </View>
              <Text style={[styles.channelName, { color: colors.text }]}>
                Canal {item}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* Canais Recentes */}
      <View style={styles.section}>
        <Text style={[styles.sectionTitle, { color: colors.text }]}>Assistidos Recentemente</Text>
        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          {[1, 2, 3, 4].map((item) => (
            <TouchableOpacity
              key={item}
              style={[styles.recentChannel, { backgroundColor: colors.surface }]}
            >
              <View style={[styles.recentChannelLogo, { backgroundColor: colors.secondary }]}>
                <Text style={styles.channelLogoText}>📺</Text>
              </View>
              <Text style={[styles.recentChannelName, { color: colors.text }]}>
                Canal Recente {item}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>
    </ScrollView>
  );
};

// Tela de Filmes
const MoviesScreen: React.FC = () => {
  const { colors } = useTheme();
  
  return (
    <ScrollView style={[styles.container, { backgroundColor: colors.background }]}>
      <StatusBar barStyle="light-content" backgroundColor={colors.background} />
      
      {/* Header */}
      <View style={styles.header}>
        <Text style={[styles.title, { color: colors.text }]}>🎬 Filmes</Text>
        <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
          Milhares de filmes para você assistir
        </Text>
      </View>

      {/* Gêneros */}
      <View style={styles.section}>
        <Text style={[styles.sectionTitle, { color: colors.text }]}>Gêneros</Text>
        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          {['Ação', 'Comédia', 'Drama', 'Ficção', 'Terror', 'Romance', 'Aventura'].map((genre, index) => (
            <TouchableOpacity
              key={index}
              style={[styles.categoryChip, { backgroundColor: colors.surface }]}
            >
              <Text style={[styles.categoryText, { color: colors.text }]}>{genre}</Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      {/* Filmes em Destaque */}
      <View style={styles.section}>
        <Text style={[styles.sectionTitle, { color: colors.text }]}>Em Destaque</Text>
        <View style={styles.movieGrid}>
          {[1, 2, 3, 4, 5, 6].map((item) => (
            <TouchableOpacity
              key={item}
              style={[styles.movieCard, { backgroundColor: colors.surface }]}
            >
              <View style={[styles.moviePoster, { backgroundColor: colors.primary }]}>
                <Text style={styles.moviePosterText}>🎬</Text>
              </View>
              <Text style={[styles.movieTitle, { color: colors.text }]}>
                Filme {item}
              </Text>
              <Text style={[styles.movieYear, { color: colors.textSecondary }]}>
                2024
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>
    </ScrollView>
  );
};

// Tela de Séries
const SeriesScreen: React.FC = () => {
  const { colors } = useTheme();
  
  return (
    <ScrollView style={[styles.container, { backgroundColor: colors.background }]}>
      <StatusBar barStyle="light-content" backgroundColor={colors.background} />
      
      {/* Header */}
      <View style={styles.header}>
        <Text style={[styles.title, { color: colors.text }]}>📺 Séries</Text>
        <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
          Suas séries favoritas com todos os episódios
        </Text>
      </View>

      {/* Séries em Destaque */}
      <View style={styles.section}>
        <Text style={[styles.sectionTitle, { color: colors.text }]}>Em Destaque</Text>
        <View style={styles.seriesGrid}>
          {[1, 2, 3, 4, 5, 6].map((item) => (
            <TouchableOpacity
              key={item}
              style={[styles.seriesCard, { backgroundColor: colors.surface }]}
            >
              <View style={[styles.seriesPoster, { backgroundColor: colors.secondary }]}>
                <Text style={styles.seriesPosterText}>📺</Text>
              </View>
              <Text style={[styles.seriesTitle, { color: colors.text }]}>
                Série {item}
              </Text>
              <Text style={[styles.seriesSeasons, { color: colors.textSecondary }]}>
                3 Temporadas
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>
    </ScrollView>
  );
};

// Tela de Favoritos
const FavoritesScreen: React.FC = () => {
  const { colors } = useTheme();
  
  return (
    <ScrollView style={[styles.container, { backgroundColor: colors.background }]}>
      <StatusBar barStyle="light-content" backgroundColor={colors.background} />
      
      {/* Header */}
      <View style={styles.header}>
        <Text style={[styles.title, { color: colors.text }]}>❤️ Favoritos</Text>
        <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
          Seus canais, filmes e séries favoritos
        </Text>
      </View>

      {/* Lista de Favoritos */}
      <View style={styles.section}>
        <Text style={[styles.sectionTitle, { color: colors.text }]}>Seus Favoritos</Text>
        <Text style={[styles.emptyText, { color: colors.textSecondary }]}>
          Você ainda não tem favoritos. Comece a adicionar canais, filmes e séries!
        </Text>
      </View>
    </ScrollView>
  );
};

// Tela de Configurações
const SettingsScreen: React.FC = () => {
  const { colors } = useTheme();
  const { logout } = useAuth();
  
  return (
    <ScrollView style={[styles.container, { backgroundColor: colors.background }]}>
      <StatusBar barStyle="light-content" backgroundColor={colors.background} />
      
      {/* Header */}
      <View style={styles.header}>
        <Text style={[styles.title, { color: colors.text }]}>⚙️ Configurações</Text>
        <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
          Personalize sua experiência
        </Text>
      </View>

      {/* Opções de Configuração */}
      <View style={styles.section}>
        <TouchableOpacity style={[styles.settingItem, { backgroundColor: colors.surface }]}>
          <Text style={[styles.settingText, { color: colors.text }]}>Servidores IPTV</Text>
          <Text style={[styles.settingArrow, { color: colors.textSecondary }]}>›</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={[styles.settingItem, { backgroundColor: colors.surface }]}>
          <Text style={[styles.settingText, { color: colors.text }]}>Tema</Text>
          <Text style={[styles.settingArrow, { color: colors.textSecondary }]}>›</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={[styles.settingItem, { backgroundColor: colors.surface }]}>
          <Text style={[styles.settingText, { color: colors.text }]}>Qualidade do Vídeo</Text>
          <Text style={[styles.settingArrow, { color: colors.textSecondary }]}>›</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={[styles.settingItem, { backgroundColor: colors.surface }]}>
          <Text style={[styles.settingText, { color: colors.text }]}>Atualizações Automáticas</Text>
          <Text style={[styles.settingArrow, { color: colors.textSecondary }]}>›</Text>
        </TouchableOpacity>
        
        <TouchableOpacity 
          style={[styles.settingItem, { backgroundColor: colors.error + '20' }]}
          onPress={logout}
        >
          <Text style={[styles.settingText, { color: colors.error }]}>Sair</Text>
          <Text style={[styles.settingArrow, { color: colors.error }]}>›</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
};

// Navegador principal com abas
const HomeScreen: React.FC = () => {
  const { colors } = useTheme();

  return (
    <Tab.Navigator
      screenOptions={{
        headerShown: false,
        tabBarStyle: {
          backgroundColor: colors.surface,
          borderTopColor: colors.border,
          height: 60,
          paddingBottom: 8,
          paddingTop: 8,
        },
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.textSecondary,
        tabBarLabelStyle: {
          fontSize: 12,
          fontWeight: '600',
        },
      }}
    >
      <Tab.Screen
        name="Live"
        component={LiveChannelsScreen}
        options={{
          tabBarLabel: 'Ao Vivo',
          tabBarIcon: ({ color, size }) => (
            <Text style={{ color, fontSize: size }}>📺</Text>
          ),
        }}
      />
      <Tab.Screen
        name="Movies"
        component={MoviesScreen}
        options={{
          tabBarLabel: 'Filmes',
          tabBarIcon: ({ color, size }) => (
            <Text style={{ color, fontSize: size }}>🎬</Text>
          ),
        }}
      />
      <Tab.Screen
        name="Series"
        component={SeriesScreen}
        options={{
          tabBarLabel: 'Séries',
          tabBarIcon: ({ color, size }) => (
            <Text style={{ color, fontSize: size }}>📺</Text>
          ),
        }}
      />
      <Tab.Screen
        name="Favorites"
        component={FavoritesScreen}
        options={{
          tabBarLabel: 'Favoritos',
          tabBarIcon: ({ color, size }) => (
            <Text style={{ color, fontSize: size }}>❤️</Text>
          ),
        }}
      />
      <Tab.Screen
        name="Settings"
        component={SettingsScreen}
        options={{
          tabBarLabel: 'Config',
          tabBarIcon: ({ color, size }) => (
            <Text style={{ color, fontSize: size }}>⚙️</Text>
          ),
        }}
      />
    </Tab.Navigator>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    padding: AppConstants.spacing.xl,
    paddingTop: 60,
  },
  title: {
    fontSize: AppConstants.typography.h1.fontSize,
    fontWeight: AppConstants.typography.h1.fontWeight as any,
    marginBottom: AppConstants.spacing.sm,
  },
  subtitle: {
    fontSize: AppConstants.typography.body.fontSize,
    opacity: 0.8,
  },
  section: {
    marginBottom: AppConstants.spacing.xl,
    paddingHorizontal: AppConstants.spacing.xl,
  },
  sectionTitle: {
    fontSize: AppConstants.typography.h3.fontSize,
    fontWeight: AppConstants.typography.h3.fontWeight as any,
    marginBottom: AppConstants.spacing.md,
  },
  categoryChip: {
    paddingHorizontal: AppConstants.spacing.md,
    paddingVertical: AppConstants.spacing.sm,
    borderRadius: AppConstants.borderRadius.round,
    marginRight: AppConstants.spacing.sm,
  },
  categoryText: {
    fontSize: AppConstants.typography.caption.fontSize,
    fontWeight: '500',
  },
  channelGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  channelCard: {
    width: (width - AppConstants.spacing.xl * 3) / 2,
    padding: AppConstants.spacing.md,
    borderRadius: AppConstants.borderRadius.md,
    alignItems: 'center',
    marginBottom: AppConstants.spacing.md,
  },
  channelLogo: {
    width: 60,
    height: 60,
    borderRadius: 30,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: AppConstants.spacing.sm,
  },
  channelLogoText: {
    fontSize: 24,
  },
  channelName: {
    fontSize: AppConstants.typography.caption.fontSize,
    textAlign: 'center',
    fontWeight: '500',
  },
  recentChannel: {
    width: 120,
    padding: AppConstants.spacing.md,
    borderRadius: AppConstants.borderRadius.md,
    alignItems: 'center',
    marginRight: AppConstants.spacing.md,
  },
  recentChannelLogo: {
    width: 50,
    height: 50,
    borderRadius: 25,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: AppConstants.spacing.sm,
  },
  recentChannelName: {
    fontSize: AppConstants.typography.caption.fontSize,
    textAlign: 'center',
    fontWeight: '500',
  },
  movieGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  movieCard: {
    width: (width - AppConstants.spacing.xl * 3) / 2,
    padding: AppConstants.spacing.md,
    borderRadius: AppConstants.borderRadius.md,
    alignItems: 'center',
    marginBottom: AppConstants.spacing.md,
  },
  moviePoster: {
    width: 80,
    height: 120,
    borderRadius: AppConstants.borderRadius.md,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: AppConstants.spacing.sm,
  },
  moviePosterText: {
    fontSize: 32,
  },
  movieTitle: {
    fontSize: AppConstants.typography.caption.fontSize,
    textAlign: 'center',
    fontWeight: '600',
    marginBottom: AppConstants.spacing.xs,
  },
  movieYear: {
    fontSize: AppConstants.typography.caption.fontSize,
    opacity: 0.7,
  },
  seriesGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  seriesCard: {
    width: (width - AppConstants.spacing.xl * 3) / 2,
    padding: AppConstants.spacing.md,
    borderRadius: AppConstants.borderRadius.md,
    alignItems: 'center',
    marginBottom: AppConstants.spacing.md,
  },
  seriesPoster: {
    width: 80,
    height: 120,
    borderRadius: AppConstants.borderRadius.md,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: AppConstants.spacing.sm,
  },
  seriesPosterText: {
    fontSize: 32,
  },
  seriesTitle: {
    fontSize: AppConstants.typography.caption.fontSize,
    textAlign: 'center',
    fontWeight: '600',
    marginBottom: AppConstants.spacing.xs,
  },
  seriesSeasons: {
    fontSize: AppConstants.typography.caption.fontSize,
    opacity: 0.7,
  },
  emptyText: {
    fontSize: AppConstants.typography.body.fontSize,
    textAlign: 'center',
    fontStyle: 'italic',
    marginTop: AppConstants.spacing.xl,
  },
  settingItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: AppConstants.spacing.md,
    borderRadius: AppConstants.borderRadius.md,
    marginBottom: AppConstants.spacing.sm,
  },
  settingText: {
    fontSize: AppConstants.typography.body.fontSize,
    fontWeight: '500',
  },
  settingArrow: {
    fontSize: 18,
    fontWeight: 'bold',
  },
});

export default HomeScreen;
