# 📺 Axion TV

![Axion TV Logo](assets/images/axion_logo.png)

**Axion TV** é um reprodutor IPTV moderno e elegante desenvolvido em Flutter, projetado para oferecer a melhor experiência de visualização em múltiplas plataformas.

## ✨ Características Principais

- 🎯 **Interface Adaptativa**: Design otimizado para TV e dispositivos móveis
- 📡 **Suporte IPTV**: Playlists M3U e Xtream Codes
- 📺 **EPG Completo**: Guia de programação eletrônica
- 🎬 **Player Avançado**: Suporte a legendas e múltiplas faixas de áudio
- ❤️ **Sistema de Favoritos**: Organize seus canais preferidos
- 📱 **Multiplataforma**: Android, iOS, Android TV, Apple TV
- 🌙 **Temas**: Modo claro e escuro
- 🔒 **Controle Parental**: Proteção para conteúdo sensível

## 🚀 Plataformas Suportadas

- **Android** (telefones e tablets)
- **Android TV** / **Fire TV**
- **iOS** (iPhone e iPad)
- **Apple TV**

## 🛠️ Tecnologias Utilizadas

- **Flutter** 3.10+
- **Dart** 3.0+
- **Riverpod** para gerenciamento de estado
- **Go Router** para navegação
- **Hive** para armazenamento local
- **Dio** para requisições HTTP
- **Video Player** para reprodução de mídia

## 📋 Pré-requisitos

- **Flutter SDK** (versão 3.10.0 ou superior)
- **Dart SDK** (incluído com Flutter)
- **Android Studio** ou **VS Code** com extensões Flutter/Dart
- **Xcode** (para desenvolvimento iOS/macOS)
- **Git**

## 🔧 Instalação e Configuração

### 1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/axiontv.app.git
cd axiontv.app
```

### 2. Instale as dependências
```bash
flutter pub get
```

### 3. Execute o projeto
```bash
flutter run
```

### 4. Para gerar código (se necessário)
```bash
dart run build_runner build --delete-conflicting-outputs
```

## 📱 Como Usar

### Primeira Execução
1. **Splash Screen**: Aguarde a inicialização do aplicativo
2. **Onboarding**: Conheça os recursos principais
3. **Login/Registro**: Crie sua conta ou faça login
4. **Configuração**: Adicione sua playlist IPTV

### Navegação Principal
- **Canais**: Visualize todos os canais disponíveis
- **Favoritos**: Acesse rapidamente seus canais preferidos
- **Histórico**: Veja canais assistidos recentemente
- **Configurações**: Personalize a experiência

### Controles do Player
- **Play/Pause**: Toque na tela ou use o botão central
- **Navegação**: Deslize para ajustar volume e progresso
- **Qualidade**: Selecione a resolução desejada
- **Legendas**: Ative/desative legendas disponíveis

## 🏗️ Estrutura do Projeto

```
lib/
├── core/                    # Funcionalidades principais
│   ├── constants/          # Constantes da aplicação
│   ├── providers/          # Gerenciamento de estado
│   ├── router/             # Sistema de roteamento
│   └── theme/              # Temas e estilos
├── features/               # Funcionalidades específicas
│   ├── auth/               # Autenticação
│   ├── home/               # Tela principal
│   ├── player/             # Reprodutor de vídeo
│   ├── favorites/          # Sistema de favoritos
│   ├── search/             # Busca de conteúdo
│   └── settings/           # Configurações
└── main.dart               # Ponto de entrada
```

## 🔐 Configuração de Playlist IPTV

### Formato M3U
```m3u
#EXTM3U
#EXTINF:-1 tvg-id="globo" tvg-name="Globo" tvg-logo="https://exemplo.com/globo.png",Globo
https://exemplo.com/globo.m3u8
```

### Formato Xtream Codes
```
URL: http://exemplo.com:8080
Usuário: seu_usuario
Senha: sua_senha
```

## 🎨 Personalização

### Temas
O aplicativo suporta temas claro e escuro, com cores personalizáveis através do arquivo `lib/core/constants/app_constants.dart`.

### Cores Principais
- **Primária**: #1E88E5 (Azul)
- **Secundária**: #1565C0 (Azul escuro)
- **Fundo**: #121212 (Escuro) / #FFFFFF (Claro)

## 📦 Build e Deploy

### Android
```bash
# APK de release
flutter build apk --release

# APK para Android TV
flutter build apk --release --flavor tv

# Bundle para Play Store
flutter build appbundle --release
```

### iOS
```bash
# Build para iOS
flutter build ios --release

# Build para Apple TV
flutter build ios --release --dart-define=PLATFORM=apple_tv
```

## 🧪 Testes

### Executar testes unitários
```bash
flutter test
```

### Executar testes de integração
```bash
flutter test integration_test/
```

## 🐛 Solução de Problemas

### Problemas Comuns

1. **Erro de dependências**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Problemas de build**
   ```bash
   flutter clean
   flutter build apk --debug
   ```

3. **Problemas de cache**
   ```bash
   flutter clean
   flutter pub cache repair
   ```

### Logs de Debug
```bash
flutter run --verbose
```

## 🤝 Contribuição

1. **Fork** o projeto
2. **Crie** uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. **Push** para a branch (`git push origin feature/AmazingFeature`)
5. **Abra** um Pull Request

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🙏 Agradecimentos

- **Flutter Team** pelo framework incrível
- **Comunidade Flutter** pelo suporte contínuo
- **Contribuidores** que ajudaram a melhorar o projeto

## 📞 Suporte

- **Email**: suporte@axiontv.com
- **Issues**: [GitHub Issues](https://github.com/seu-usuario/axiontv.app/issues)
- **Documentação**: [Wiki do Projeto](https://github.com/seu-usuario/axiontv.app/wiki)

## 🔄 Changelog

### v1.0.0 (2024-01-XX)
- ✨ Lançamento inicial
- 🎯 Interface adaptativa para TV e mobile
- 📡 Suporte a playlists IPTV
- 📺 Sistema EPG básico
- ❤️ Sistema de favoritos
- 🌙 Temas claro e escuro

---

**Desenvolvido com ❤️ pela equipe Axion TV**
