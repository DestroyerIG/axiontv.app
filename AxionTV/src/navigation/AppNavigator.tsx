import React, { useEffect, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import AsyncStorage from '@react-native-async-storage/async-storage';

import { useAuth } from '../contexts/AuthContext';
import SplashScreen from '../screens/SplashScreen';
import OnboardingScreen from '../screens/OnboardingScreen';
import LoginScreen from '../screens/LoginScreen';
import HomeScreen from '../screens/HomeScreen';
import PlayerScreen from '../screens/PlayerScreen';
import FavoritesScreen from '../screens/FavoritesScreen';
import SearchScreen from '../screens/SearchScreen';
import SettingsScreen from '../screens/SettingsScreen';

import { RootStackParamList } from '../types';

const Stack = createStackNavigator<RootStackParamList>();

const AppNavigator: React.FC = () => {
  const { isAuthenticated, isLoading } = useAuth();
  const [isFirstLaunch, setIsFirstLaunch] = useState<boolean | null>(null);
  const [isLoadingApp, setIsLoadingApp] = useState(true);

  useEffect(() => {
    checkFirstLaunch();
  }, []);

  const checkFirstLaunch = async () => {
    try {
      const hasLaunched = await AsyncStorage.getItem('axion_tv_has_launched');
      setIsFirstLaunch(hasLaunched === null);
    } catch (error) {
      console.error('Erro ao verificar primeiro lançamento:', error);
      setIsFirstLaunch(true);
    } finally {
      setIsLoadingApp(false);
    }
  };

  const handleSplashFinish = () => {
    setIsLoadingApp(false);
  };

  const handleOnboardingComplete = async () => {
    try {
      await AsyncStorage.setItem('axion_tv_has_launched', 'true');
      setIsFirstLaunch(false);
    } catch (error) {
      console.error('Erro ao salvar status de primeiro lançamento:', error);
    }
  };

  const handleLoginSuccess = () => {
    // O contexto de autenticação já atualiza o estado
  };

  if (isLoading || isFirstLaunch === null || isLoadingApp) {
    return <SplashScreen onFinish={handleSplashFinish} />;
  }

  if (isFirstLaunch) {
    return <OnboardingScreen onComplete={handleOnboardingComplete} />;
  }

  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerShown: false,
          gestureEnabled: true,
          cardStyleInterpolator: ({ current, layouts }) => {
            return {
              cardStyle: {
                transform: [
                  {
                    translateX: current.progress.interpolate({
                      inputRange: [0, 1],
                      outputRange: [layouts.screen.width, 0],
                    }),
                  },
                ],
              },
            };
          },
        }}
      >
        {!isAuthenticated ? (
          // Telas de autenticação
          <Stack.Screen name="Login" component={LoginScreen} />
        ) : (
          // Telas principais da aplicação
          <>
            <Stack.Screen name="Home" component={HomeScreen} />
            <Stack.Screen name="Player" component={PlayerScreen} />
            <Stack.Screen name="Favorites" component={FavoritesScreen} />
            <Stack.Screen name="Search" component={SearchScreen} />
            <Stack.Screen name="Settings" component={SettingsScreen} />
          </>
        )}
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default AppNavigator;
