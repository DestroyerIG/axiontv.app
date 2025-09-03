import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { useTheme } from '../contexts/ThemeContext';
import AppConstants from '../constants/AppConstants';

const SearchScreen: React.FC = () => {
  const { colors } = useTheme();

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text style={[styles.title, { color: colors.text }]}>
        🔍 Busca
      </Text>
      <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
        Busque por canais, programas ou categorias
      </Text>
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
  title: {
    fontSize: AppConstants.typography.h1.fontSize,
    fontWeight: AppConstants.typography.h1.fontWeight as any,
    marginBottom: AppConstants.spacing.lg,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: AppConstants.typography.body.fontSize,
    textAlign: 'center',
    lineHeight: 24,
  },
});

export default SearchScreen;
