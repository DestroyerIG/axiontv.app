import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  ScrollView,
  StatusBar,
  KeyboardAvoidingView,
  Platform,
  Alert,
  Dimensions,
} from 'react-native';
import { useTheme } from '../contexts/ThemeContext';
import { useAuth } from '../contexts/AuthContext';
import AppConstants from '../constants/AppConstants';

const { width, height } = Dimensions.get('window');

interface LoginScreenProps {
  onLoginSuccess: () => void;
}

const LoginScreen: React.FC<LoginScreenProps> = ({ onLoginSuccess }) => {
  const { colors } = useTheme();
  const { login, isLoading, error, clearError } = useAuth();
  
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [serverUrl, setServerUrl] = useState('');
  const [serverType, setServerType] = useState<'xtream' | 'm3u'>('xtream');
  const [serverName, setServerName] = useState('');

  const handleSubmit = async () => {
    if (!serverUrl.trim()) {
      Alert.alert('Erro', 'Por favor, insira a URL do servidor');
      return;
    }

    if (serverType === 'xtream' && (!username.trim() || !password.trim())) {
      Alert.alert('Erro', 'Para servidores Xtream Codes, usuário e senha são obrigatórios');
      return;
    }

    // Validar URL
    try {
      new URL(serverUrl);
    } catch {
      Alert.alert('Erro', 'Por favor, insira uma URL válida');
      return;
    }

    const success = await login(username, password, serverUrl, serverType);
    if (success) {
      onLoginSuccess();
    }
  };

  const toggleServerType = () => {
    setServerType(serverType === 'xtream' ? 'm3u' : 'xtream');
    clearError();
  };

  return (
    <KeyboardAvoidingView
      style={[styles.container, { backgroundColor: colors.background }]}
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
    >
      <StatusBar
        barStyle="light-content"
        backgroundColor={colors.background}
        translucent
      />
      
      <ScrollView
        contentContainerStyle={styles.scrollContainer}
        showsVerticalScrollIndicator={false}
      >
        {/* Header com Logo */}
        <View style={styles.header}>
          <View style={[styles.logoContainer, { backgroundColor: colors.primary }]}>
            <Text style={styles.logoText}>📺</Text>
          </View>
          <Text style={[styles.title, { color: colors.text }]}>
            {AppConstants.appName}
          </Text>
          <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
            Conecte-se ao seu servidor IPTV
          </Text>
        </View>

        {/* Card de Login */}
        <View style={[styles.loginCard, { backgroundColor: colors.surface }]}>
          {/* Tipo de Servidor */}
          <View style={styles.serverTypeContainer}>
            <Text style={[styles.sectionLabel, { color: colors.text }]}>
              Tipo de Servidor
            </Text>
            <View style={styles.serverTypeToggle}>
              <TouchableOpacity
                style={[
                  styles.serverTypeButton,
                  {
                    backgroundColor: serverType === 'xtream' ? colors.primary : 'transparent',
                    borderColor: colors.primary,
                  },
                ]}
                onPress={() => setServerType('xtream')}
              >
                <Text
                  style={[
                    styles.serverTypeText,
                    {
                      color: serverType === 'xtream' ? colors.text : colors.primary,
                    },
                  ]}
                >
                  Xtream Codes
                </Text>
              </TouchableOpacity>
              
              <TouchableOpacity
                style={[
                  styles.serverTypeButton,
                  {
                    backgroundColor: serverType === 'm3u' ? colors.primary : 'transparent',
                    borderColor: colors.primary,
                  },
                ]}
                onPress={() => setServerType('m3u')}
              >
                <Text
                  style={[
                    styles.serverTypeText,
                    {
                      color: serverType === 'm3u' ? colors.text : colors.primary,
                    },
                  ]}
                >
                  M3U Playlist
                </Text>
              </TouchableOpacity>
            </View>
          </View>

          {/* Nome do Servidor */}
          <View style={styles.inputContainer}>
            <Text style={[styles.label, { color: colors.text }]}>
              Nome do Servidor
            </Text>
            <TextInput
              style={[
                styles.input,
                {
                  backgroundColor: colors.card,
                  color: colors.text,
                  borderColor: colors.border,
                },
              ]}
              placeholder="Ex: Meu Servidor IPTV"
              placeholderTextColor={colors.textTertiary}
              value={serverName}
              onChangeText={setServerName}
              autoCapitalize="words"
            />
          </View>

          {/* URL do Servidor */}
          <View style={styles.inputContainer}>
            <Text style={[styles.label, { color: colors.text }]}>
              {serverType === 'xtream' ? 'URL do Servidor' : 'URL da Playlist M3U'}
            </Text>
            <TextInput
              style={[
                styles.input,
                {
                  backgroundColor: colors.card,
                  color: colors.text,
                  borderColor: colors.border,
                },
              ]}
              placeholder={serverType === 'xtream' ? 'http://servidor.com:porta' : 'https://exemplo.com/playlist.m3u'}
              placeholderTextColor={colors.textTertiary}
              value={serverUrl}
              onChangeText={setServerUrl}
              autoCapitalize="none"
              autoCorrect={false}
              keyboardType="url"
            />
          </View>

          {/* Usuário (apenas para Xtream) */}
          {serverType === 'xtream' && (
            <View style={styles.inputContainer}>
              <Text style={[styles.label, { color: colors.text }]}>Usuário</Text>
              <TextInput
                style={[
                  styles.input,
                  {
                    backgroundColor: colors.card,
                    color: colors.text,
                    borderColor: colors.border,
                  },
                ]}
                placeholder="Digite seu usuário"
                placeholderTextColor={colors.textTertiary}
                value={username}
                onChangeText={setUsername}
                autoCapitalize="none"
                autoCorrect={false}
              />
            </View>
          )}

          {/* Senha (apenas para Xtream) */}
          {serverType === 'xtream' && (
            <View style={styles.inputContainer}>
              <Text style={[styles.label, { color: colors.text }]}>Senha</Text>
              <TextInput
                style={[
                  styles.input,
                  {
                    backgroundColor: colors.card,
                    color: colors.text,
                    borderColor: colors.border,
                  },
                ]}
                placeholder="Digite sua senha"
                placeholderTextColor={colors.textTertiary}
                value={password}
                onChangeText={setPassword}
                secureTextEntry
                autoCapitalize="none"
              />
            </View>
          )}

          {/* Mensagem de erro */}
          {error && (
            <View style={[styles.errorContainer, { backgroundColor: colors.error + '15' }]}>
              <Text style={[styles.errorText, { color: colors.error }]}>
                {error}
              </Text>
              <TouchableOpacity onPress={clearError} style={styles.closeError}>
                <Text style={[styles.closeErrorText, { color: colors.error }]}>✕</Text>
              </TouchableOpacity>
            </View>
          )}

          {/* Botão de Conectar */}
          <TouchableOpacity
            style={[
              styles.connectButton,
              {
                backgroundColor: colors.primary,
                opacity: isLoading ? 0.7 : 1,
              },
            ]}
            onPress={handleSubmit}
            disabled={isLoading}
          >
            <Text style={[styles.connectButtonText, { color: colors.text }]}>
              {isLoading ? 'Conectando...' : 'Conectar ao Servidor'}
            </Text>
          </TouchableOpacity>

          {/* Informações de Ajuda */}
          <View style={styles.helpContainer}>
            <Text style={[styles.helpTitle, { color: colors.text }]}>
              Precisa de ajuda?
            </Text>
            <Text style={[styles.helpText, { color: colors.textSecondary }]}>
              {serverType === 'xtream' 
                ? 'Para servidores Xtream Codes, você precisa de usuário, senha e URL do servidor'
                : 'Para playlists M3U, apenas a URL da playlist é necessária'
              }
            </Text>
          </View>
        </View>

        {/* Footer */}
        <View style={styles.footer}>
          <Text style={[styles.footerText, { color: colors.textTertiary }]}>
            Ao conectar, você concorda com nossos{' '}
            <Text style={{ color: colors.primary }}>Termos de Uso</Text> e{' '}
            <Text style={{ color: colors.primary }}>Política de Privacidade</Text>
          </Text>
        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  scrollContainer: {
    flexGrow: 1,
    paddingHorizontal: AppConstants.spacing.xl,
    paddingTop: 60,
    paddingBottom: AppConstants.spacing.xl,
  },
  header: {
    alignItems: 'center',
    marginBottom: AppConstants.spacing.xxl,
  },
  logoContainer: {
    width: 100,
    height: 100,
    borderRadius: 50,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: AppConstants.spacing.lg,
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
    fontSize: 48,
  },
  title: {
    fontSize: AppConstants.typography.h1.fontSize,
    fontWeight: AppConstants.typography.h1.fontWeight as any,
    marginBottom: AppConstants.spacing.sm,
    textAlign: 'center',
    letterSpacing: AppConstants.typography.h1.letterSpacing,
  },
  subtitle: {
    fontSize: AppConstants.typography.bodyLarge.fontSize,
    textAlign: 'center',
    opacity: 0.8,
    lineHeight: AppConstants.typography.bodyLarge.lineHeight,
  },
  loginCard: {
    borderRadius: AppConstants.borderRadius.xl,
    padding: AppConstants.spacing.xl,
    marginBottom: AppConstants.spacing.xxl,
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 8,
  },
  serverTypeContainer: {
    marginBottom: AppConstants.spacing.lg,
  },
  sectionLabel: {
    fontSize: AppConstants.typography.bodyMedium.fontSize,
    fontWeight: AppConstants.typography.bodyMedium.fontWeight as any,
    marginBottom: AppConstants.spacing.md,
  },
  serverTypeToggle: {
    flexDirection: 'row',
    borderRadius: AppConstants.borderRadius.md,
    borderWidth: 2,
    borderColor: AppConstants.colors.primary,
    overflow: 'hidden',
  },
  serverTypeButton: {
    flex: 1,
    paddingVertical: AppConstants.spacing.md,
    alignItems: 'center',
    justifyContent: 'center',
  },
  serverTypeText: {
    fontSize: AppConstants.typography.bodyMedium.fontSize,
    fontWeight: AppConstants.typography.bodyMedium.fontWeight as any,
  },
  inputContainer: {
    marginBottom: AppConstants.spacing.lg,
  },
  label: {
    fontSize: AppConstants.typography.bodyMedium.fontSize,
    fontWeight: AppConstants.typography.bodyMedium.fontWeight as any,
    marginBottom: AppConstants.spacing.sm,
  },
  input: {
    height: 56,
    borderWidth: 1,
    borderRadius: AppConstants.borderRadius.md,
    paddingHorizontal: AppConstants.spacing.md,
    fontSize: AppConstants.typography.body.fontSize,
  },
  errorContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: AppConstants.spacing.md,
    borderRadius: AppConstants.borderRadius.md,
    marginBottom: AppConstants.spacing.lg,
  },
  errorText: {
    flex: 1,
    fontSize: AppConstants.typography.caption.fontSize,
  },
  closeError: {
    padding: AppConstants.spacing.xs,
  },
  closeErrorText: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  connectButton: {
    height: 56,
    borderRadius: AppConstants.borderRadius.md,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: AppConstants.spacing.lg,
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 4,
  },
  connectButtonText: {
    fontSize: AppConstants.typography.buttonLarge.fontSize,
    fontWeight: AppConstants.typography.buttonLarge.fontWeight as any,
    letterSpacing: AppConstants.typography.buttonLarge.letterSpacing,
  },
  helpContainer: {
    padding: AppConstants.spacing.md,
    backgroundColor: 'rgba(99, 102, 241, 0.1)',
    borderRadius: AppConstants.borderRadius.md,
    borderLeftWidth: 4,
    borderLeftColor: AppConstants.colors.primary,
  },
  helpTitle: {
    fontSize: AppConstants.typography.bodyMedium.fontSize,
    fontWeight: AppConstants.typography.bodyMedium.fontWeight as any,
    marginBottom: AppConstants.spacing.xs,
  },
  helpText: {
    fontSize: AppConstants.typography.caption.fontSize,
    lineHeight: AppConstants.typography.caption.lineHeight,
  },
  footer: {
    alignItems: 'center',
  },
  footerText: {
    fontSize: AppConstants.typography.caption.fontSize,
    textAlign: 'center',
    lineHeight: 20,
  },
});

export default LoginScreen;
