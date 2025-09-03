import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { useColorScheme } from 'react-native';
import AppConstants from '../constants/AppConstants';

interface ThemeContextType {
  theme: 'light' | 'dark' | 'system';
  isDark: boolean;
  colors: typeof AppConstants.colors;
  setTheme: (theme: 'light' | 'dark' | 'system') => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

interface ThemeProviderProps {
  children: ReactNode;
}

export const ThemeProvider: React.FC<ThemeProviderProps> = ({ children }) => {
  const systemColorScheme = useColorScheme();
  const [theme, setTheme] = useState<'light' | 'dark' | 'system'>('system');

  const isDark = theme === 'system' 
    ? systemColorScheme === 'dark'
    : theme === 'dark';

  const colors = {
    ...AppConstants.colors,
    background: isDark ? AppConstants.colors.background : AppConstants.themes.light.background,
    surface: isDark ? AppConstants.colors.surface : AppConstants.themes.light.surface,
    text: isDark ? AppConstants.colors.text : AppConstants.themes.light.text,
    textSecondary: isDark ? AppConstants.colors.textSecondary : AppConstants.themes.light.textSecondary,
  };

  const value: ThemeContextType = {
    theme,
    isDark,
    colors,
    setTheme,
  };

  return (
    <ThemeContext.Provider value={value}>
      {children}
    </ThemeContext.Provider>
  );
};

export const useTheme = (): ThemeContextType => {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
};

export default ThemeContext;
