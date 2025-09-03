import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { User, AuthState, Server, XtreamServer, M3UServer } from '../types';

interface AuthContextType extends AuthState {
  login: (username: string, password: string, serverUrl: string, serverType: 'xtream' | 'm3u') => Promise<boolean>;
  logout: () => Promise<void>;
  addServer: (server: Server) => Promise<void>;
  removeServer: (serverId: string) => Promise<void>;
  clearError: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

interface AuthProviderProps {
  children: ReactNode;
}

export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
  const [state, setState] = useState<AuthState>({
    isAuthenticated: false,
    user: null,
    isLoading: true,
    error: null,
  });

  useEffect(() => {
    checkAuthStatus();
  }, []);

  const checkAuthStatus = async () => {
    try {
      const userData = await AsyncStorage.getItem('axion_tv_user');
      const serversData = await AsyncStorage.getItem('axion_tv_servers');
      
      if (userData && serversData) {
        const user: User = JSON.parse(userData);
        const servers: Server[] = JSON.parse(serversData);
        
        user.servers = servers;
        
        setState({
          isAuthenticated: true,
          user,
          isLoading: false,
          error: null,
        });
      } else {
        setState(prev => ({ ...prev, isLoading: false }));
      }
    } catch (error) {
      console.error('Erro ao verificar status de autenticação:', error);
      setState(prev => ({ ...prev, isLoading: false }));
    }
  };

  const login = async (username: string, password: string, serverUrl: string, serverType: 'xtream' | 'm3u'): Promise<boolean> => {
    try {
      setState(prev => ({ ...prev, isLoading: true, error: null }));
      
      // Simular chamada de API para conectar ao servidor
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      // Criar servidor baseado no tipo
      let server: Server;
      
      if (serverType === 'xtream') {
        server = {
          id: Date.now().toString(),
          name: `Servidor ${username}`,
          url: serverUrl,
          username,
          password,
          type: 'xtream',
          lastUpdated: new Date(),
          isActive: true,
        } as XtreamServer;
      } else {
        server = {
          id: Date.now().toString(),
          name: 'Playlist M3U',
          url: serverUrl,
          type: 'm3u',
          lastUpdated: new Date(),
          isActive: true,
        } as M3UServer;
      }

      // Mock de usuário para demonstração
      const user: User = {
        id: '1',
        username: serverType === 'xtream' ? username : 'user',
        email: `${username}@example.com`,
        isPremium: true,
        createdAt: new Date(),
        lastLogin: new Date(),
        servers: [server],
      };

      // Salvar dados no AsyncStorage
      await AsyncStorage.setItem('axion_tv_user', JSON.stringify(user));
      await AsyncStorage.setItem('axion_tv_servers', JSON.stringify([server]));
      
      setState({
        isAuthenticated: true,
        user,
        isLoading: false,
        error: null,
      });
      
      return true;
    } catch (error) {
      const errorMessage = 'Erro ao conectar ao servidor. Verifique suas credenciais.';
      setState(prev => ({
        ...prev,
        isLoading: false,
        error: errorMessage,
      }));
      return false;
    }
  };

  const addServer = async (server: Server): Promise<void> => {
    try {
      if (state.user) {
        const updatedUser = {
          ...state.user,
          servers: [...state.user.servers, server],
        };
        
        await AsyncStorage.setItem('axion_tv_user', JSON.stringify(updatedUser));
        await AsyncStorage.setItem('axion_tv_servers', JSON.stringify(updatedUser.servers));
        
        setState(prev => ({
          ...prev,
          user: updatedUser,
        }));
      }
    } catch (error) {
      console.error('Erro ao adicionar servidor:', error);
    }
  };

  const removeServer = async (serverId: string): Promise<void> => {
    try {
      if (state.user) {
        const updatedUser = {
          ...state.user,
          servers: state.user.servers.filter(s => s.id !== serverId),
        };
        
        await AsyncStorage.setItem('axion_tv_user', JSON.stringify(updatedUser));
        await AsyncStorage.setItem('axion_tv_servers', JSON.stringify(updatedUser.servers));
        
        setState(prev => ({
          ...prev,
          user: updatedUser,
        }));
      }
    } catch (error) {
      console.error('Erro ao remover servidor:', error);
    }
  };

  const logout = async (): Promise<void> => {
    try {
      await AsyncStorage.removeItem('axion_tv_user');
      await AsyncStorage.removeItem('axion_tv_servers');
      setState({
        isAuthenticated: false,
        user: null,
        isLoading: false,
        error: null,
      });
    } catch (error) {
      console.error('Erro ao fazer logout:', error);
    }
  };

  const clearError = () => {
    setState(prev => ({ ...prev, error: null }));
  };

  const value: AuthContextType = {
    ...state,
    login,
    logout,
    addServer,
    removeServer,
    clearError,
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = (): AuthContextType => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};

export default AuthContext;
