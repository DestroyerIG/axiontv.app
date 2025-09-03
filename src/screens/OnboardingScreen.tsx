import React, { useState, useRef } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  ScrollView,
  TouchableOpacity,
  StatusBar,
} from 'react-native';
import { useTheme } from '../contexts/ThemeContext';
import AppConstants from '../constants/AppConstants';

const { width, height } = Dimensions.get('window');

interface OnboardingPage {
  id: number;
  title: string;
  description: string;
  icon: string;
}

interface OnboardingScreenProps {
  onComplete: () => void;
}

const OnboardingScreen: React.FC<OnboardingScreenProps> = ({ onComplete }) => {
  const { colors } = useTheme();
  const [currentPage, setCurrentPage] = useState(0);
  const scrollViewRef = useRef<ScrollView>(null);

  const pages: OnboardingPage[] = [
    {
      id: 1,
      title: 'Bem-vindo ao Axion TV',
      description: 'O melhor reprodutor IPTV para suas séries e filmes favoritos',
      icon: '📺',
    },
    {
      id: 2,
      title: 'Milhares de Canais',
      description: 'Acesse canais de TV de todo o mundo com qualidade HD',
      icon: '🌍',
    },
    {
      id: 3,
      title: 'EPG Completo',
      description: 'Guia de programação eletrônica para nunca perder nada',
      icon: '📅',
    },
    {
      id: 4,
      title: 'Multiplataforma',
      description: 'Assista em qualquer dispositivo: TV, tablet ou smartphone',
      icon: '📱',
    },
  ];

  const handleNext = () => {
    if (currentPage < pages.length - 1) {
      const nextPage = currentPage + 1;
      setCurrentPage(nextPage);
      scrollViewRef.current?.scrollTo({
        x: nextPage * width,
        animated: true,
      });
    } else {
      onComplete();
    }
  };

  const handleSkip = () => {
    onComplete();
  };

  const renderPage = (page: OnboardingPage, index: number) => (
    <View key={page.id} style={styles.page}>
      <View style={styles.iconContainer}>
        <Text style={styles.icon}>{page.icon}</Text>
      </View>
      
      <Text style={[styles.title, { color: colors.text }]}>
        {page.title}
      </Text>
      
      <Text style={[styles.description, { color: colors.textSecondary }]}>
        {page.description}
      </Text>
    </View>
  );

  const renderPagination = () => (
    <View style={styles.paginationContainer}>
      {pages.map((_, index) => (
        <View
          key={index}
          style={[
            styles.paginationDot,
            {
              backgroundColor: index === currentPage ? colors.primary : colors.border,
            },
          ]}
        />
      ))}
    </View>
  );

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <StatusBar
        barStyle="light-content"
        backgroundColor={colors.background}
        translucent
      />
      
      {/* Botão pular */}
      <TouchableOpacity style={styles.skipButton} onPress={handleSkip}>
        <Text style={[styles.skipText, { color: colors.textSecondary }]}>
          Pular
        </Text>
      </TouchableOpacity>

      {/* Páginas */}
      <ScrollView
        ref={scrollViewRef}
        horizontal
        pagingEnabled
        showsHorizontalScrollIndicator={false}
        onMomentumScrollEnd={(event) => {
          const pageIndex = Math.round(event.nativeEvent.contentOffset.x / width);
          setCurrentPage(pageIndex);
        }}
        style={styles.scrollView}
      >
        {pages.map((page, index) => renderPage(page, index))}
      </ScrollView>

      {/* Paginação */}
      {renderPagination()}

      {/* Botões de navegação */}
      <View style={styles.buttonContainer}>
        <TouchableOpacity
          style={[styles.button, { backgroundColor: colors.primary }]}
          onPress={handleNext}
        >
          <Text style={[styles.buttonText, { color: colors.text }]}>
            {currentPage === pages.length - 1 ? 'Começar' : 'Próximo'}
          </Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  skipButton: {
    position: 'absolute',
    top: 60,
    right: 20,
    zIndex: 1,
    padding: AppConstants.spacing.sm,
  },
  skipText: {
    fontSize: AppConstants.typography.body.fontSize,
    fontWeight: '500',
  },
  scrollView: {
    flex: 1,
  },
  page: {
    width,
    height: height - 200,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: AppConstants.spacing.xl,
  },
  iconContainer: {
    width: 120,
    height: 120,
    borderRadius: 60,
    backgroundColor: 'rgba(30, 136, 229, 0.1)',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: AppConstants.spacing.xxl,
  },
  icon: {
    fontSize: 60,
  },
  title: {
    fontSize: AppConstants.typography.h2.fontSize,
    fontWeight: AppConstants.typography.h2.fontWeight as any,
    textAlign: 'center',
    marginBottom: AppConstants.spacing.md,
  },
  description: {
    fontSize: AppConstants.typography.body.fontSize,
    textAlign: 'center',
    lineHeight: 24,
    paddingHorizontal: AppConstants.spacing.lg,
  },
  paginationContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: AppConstants.spacing.xl,
  },
  paginationDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    marginHorizontal: AppConstants.spacing.xs,
  },
  buttonContainer: {
    paddingHorizontal: AppConstants.spacing.xl,
    paddingBottom: AppConstants.spacing.xl,
  },
  button: {
    height: 56,
    borderRadius: AppConstants.borderRadius.md,
    justifyContent: 'center',
    alignItems: 'center',
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 4,
  },
  buttonText: {
    fontSize: AppConstants.typography.button.fontSize,
    fontWeight: AppConstants.typography.button.fontWeight as any,
  },
});

export default OnboardingScreen;
