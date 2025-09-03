# 📺 Axion TV - React Native

Um aplicativo IPTV multiplataforma baseado no design do **9xtream.net**, desenvolvido em React Native com TypeScript.

## 🚀 Características

### ✨ **Interface Moderna**
- Design inspirado no 9xtream.net com tema escuro elegante
- Navegação por abas intuitiva (Live, Filmes, Séries, Favoritos, Configurações)
- Animações suaves e transições fluidas
- Suporte a tema claro/escuro

### 🔐 **Autenticação e Servidores**
- **Xtream Codes**: Suporte completo com usuário, senha e URL
- **M3U Playlists**: Integração direta com URLs de playlists
- Múltiplos servidores simultâneos
- Armazenamento seguro de credenciais

### 📺 **Conteúdo IPTV**
- **Canais ao Vivo**: Grid responsivo com categorias
- **Filmes**: Biblioteca completa com busca e filtros
- **Séries**: Organização por temporadas e episódios
- **EPG**: Guia de programação eletrônica
- **Favoritos**: Sistema de favoritos sincronizado
- **Histórico**: Controle de visualização

### 🔄 **Sincronização Automática**
- Atualização automática a cada 12 horas
- Cache inteligente para melhor performance
- Sincronização em background
- Notificações de atualizações

### 🎮 **Player Avançado**
- Reprodução de streams IPTV
- Múltiplas qualidades de vídeo
- Controles de player completos
- Continuar de onde parou
- Suporte a legendas

## 🛠️ Tecnologias

- **React Native** 0.72+
- **TypeScript** para type safety
- **React Navigation** para navegação
- **AsyncStorage** para persistência local
- **Context API** para gerenciamento de estado
- **Metro Bundler** para build

## 📱 Plataformas Suportadas

- ✅ **iOS** (iPhone/iPad)
- ✅ **Android** (Smartphones/Tablets)
- 🔄 **Web** (Em desenvolvimento)
- 🔄 **Desktop** (Em desenvolvimento)

## 🚀 Como Executar

### Pré-requisitos
- Node.js 18+ ou Volta
- React Native CLI
- Xcode (para iOS)
- Android Studio (para Android)

### Instalação

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/axiontv.app.git
cd axiontv.app/axiontv
```

2. **Instale as dependências**
```bash
npm install
# ou
yarn install
```

3. **iOS (macOS apenas)**
```bash
cd ios
pod install
cd ..
npx react-native run-ios
```

4. **Android**
```bash
npx react-native run-android
```

## 📁 Estrutura do Projeto

```
src/
├── components/          # Componentes reutilizáveis
├── constants/           # Constantes da aplicação
├── contexts/            # Contextos React (Theme, Auth)
├── hooks/               # Custom hooks
├── navigation/          # Configuração de navegação
├── screens/             # Telas da aplicação
├── services/            # Serviços (API, Storage)
├── types/               # Definições TypeScript
└── utils/               # Utilitários
```

## 🎨 Design System

### Cores
- **Primária**: `#6366F1` (Indigo)
- **Secundária**: `#8B5CF6` (Violet)
- **Acento**: `#F59E0B` (Amber)
- **Fundo**: `#0F0F23` (Azul escuro)

### Tipografia
- **H1**: 32px, Weight 800
- **H2**: 28px, Weight 700
- **Body**: 16px, Weight 400
- **Caption**: 14px, Weight 400

## 🔧 Configuração

### Variáveis de Ambiente
```bash
# Crie um arquivo .env
API_BASE_URL=https://api.axiontv.com
DEFAULT_LOCALE=pt-BR
AUTO_UPDATE_INTERVAL=43200000
```

### Configurações do App
- Atualização automática: 12 horas
- Cache: 200MB
- Timeout de rede: 30 segundos
- Qualidade padrão: Auto

## 📊 Funcionalidades Principais

### 🏠 **Tela Inicial**
- Splash screen animada
- Onboarding para novos usuários
- Login com múltiplos tipos de servidor

### 📺 **Canais ao Vivo**
- Grid responsivo de canais
- Categorias organizadas
- Busca por nome
- Favoritos rápidos

### 🎬 **Filmes**
- Biblioteca completa
- Busca avançada
- Filtros por categoria/ano
- Histórico de visualização

### 📺 **Séries**
- Organização por temporadas
- Episódios numerados
- Progresso de visualização
- Continuar assistindo

### ⚙️ **Configurações**
- Tema claro/escuro
- Qualidade de vídeo
- Atualizações automáticas
- Controle parental
- Acessibilidade

## 🔒 Segurança

- Credenciais criptografadas
- Validação de URLs
- Timeout de sessão
- Controle de acesso por PIN

## 📈 Performance

- Lazy loading de imagens
- Cache inteligente
- Otimização de re-renders
- Compressão de assets

## 🧪 Testes

```bash
# Testes unitários
npm test

# Testes E2E
npm run test:e2e

# Coverage
npm run test:coverage
```

## 📦 Build e Deploy

### Android
```bash
cd android
./gradlew assembleRelease
```

### iOS
```bash
cd ios
xcodebuild -workspace AxionTV.xcworkspace -scheme AxionTV -configuration Release
```

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🆘 Suporte

- **Email**: suporte@axiontv.com
- **Issues**: [GitHub Issues](https://github.com/seu-usuario/axiontv.app/issues)
- **Documentação**: [Wiki](https://github.com/seu-usuario/axiontv.app/wiki)

## 🙏 Agradecimentos

- Design inspirado no [9xtream.net](https://9xtream.net)
- Comunidade React Native
- Contribuidores do projeto

---

**Desenvolvido com ❤️ pela equipe Axion TV**
