import React, { useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  Animated,
  StatusBar,
} from 'react-native';
import { useTheme } from '../contexts/ThemeContext';
import AppConstants from '../constants/AppConstants';

const { width, height } = Dimensions.get('window');

interface SplashScreenProps {
  onFinish: () => void;
}

const SplashScreen: React.FC<SplashScreenProps> = ({ onFinish }) => {
  const { colors } = useTheme();
  const logoScale = new Animated.Value(0);
  const logoOpacity = new Animated.Value(0);
  const textOpacity = new Animated.Value(0);

  useEffect(() => {
    const animate = async () => {
      // Animação do logo
      Animated.sequence([
        Animated.parallel([
          Animated.timing(logoScale, {
            toValue: 1,
            duration: 800,
            useNativeDriver: true,
          }),
          Animated.timing(logoOpacity, {
            toValue: 1,
            duration: 800,
            useNativeDriver: true,
          }),
        ]),
        Animated.timing(textOpacity, {
          toValue: 1,
          duration: 600,
          useNativeDriver: true,
        }),
      ]).start();

      // Aguardar 2.5 segundos antes de finalizar
      setTimeout(() => {
        onFinish();
      }, 2500);
    };

    animate();
  }, [onFinish]);

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <StatusBar
        barStyle="light-content"
        backgroundColor={colors.background}
        translucent
      />
      
      {/* Logo animado */}
      <Animated.View
        style={[
          styles.logoContainer,
          {
            opacity: logoOpacity,
            transform: [{ scale: logoScale }],
          },
        ]}
      >
        <View style={[styles.logo, { backgroundColor: colors.primary }]}>
          <Text style={[styles.logoText, { color: colors.text }]}>📺</Text>
        </View>
      </Animated.View>

      {/* Título da aplicação */}
      <Animated.Text
        style={[
          styles.title,
          {
            color: colors.text,
            opacity: textOpacity,
          },
        ]}
      >
        {AppConstants.appName}
      </Animated.Text>

      {/* Subtítulo */}
      <Animated.Text
        style={[
          styles.subtitle,
          {
            color: colors.textSecondary,
            opacity: textOpacity,
          },
        ]}
      >
        Sua TV em qualquer lugar
      </Animated.Text>

      {/* Indicador de carregamento */}
      <View style={styles.loadingContainer}>
        <View style={[styles.loadingDot, { backgroundColor: colors.primary }]} />
        <View style={[styles.loadingDot, { backgroundColor: colors.primary }]} />
        <View style={[styles.loadingDot, { backgroundColor: colors.primary }]} />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: AppConstants.spacing.xl,
  },
  logoContainer: {
    marginBottom: AppConstants.spacing.xxl,
  },
  logo: {
    width: 120,
    height: 120,
    borderRadius: 60,
    justifyContent: 'center',
    alignItems: 'center',
    elevation: 8,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 4,
    },
    shadowOpacity: 0.3,
    shadowRadius: 8,
  },
  logoText: {
    fontSize: 60,
  },
  title: {
    fontSize: AppConstants.typography.h1.fontSize,
    fontWeight: AppConstants.typography.h1.fontWeight as any,
    marginBottom: AppConstants.spacing.sm,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: AppConstants.typography.body.fontSize,
    textAlign: 'center',
    marginBottom: AppConstants.spacing.xxl,
  },
  loadingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  loadingDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    marginHorizontal: 4,
    opacity: 0.6,
  },
});

export default SplashScreen;
