# Axion TV

![Axion TV Logo](assets/images/axion_logo.png)

Reprodutor IPTV moderno para Android TV, Fire TV, Apple TV e dispositivos móveis.

## Recursos Principais

- Suporte a playlists Xtream Codes e M3U
- EPG (Guia de Programação Eletrônica)
- Player avançado com suporte a legendas e múltiplas faixas de áudio
- Interface adaptada para TV e mobile
- Favoritos e histórico de visualização
- Controle parental

## Plataformas Suportadas

- Android (telefones e tablets)
- Android TV / Fire TV
- iOS (iPhone e iPad)
- Apple TV

## Configuração

1. Clone o repositório
2. Crie um arquivo `.env` baseado no `.env.example`
3. Execute:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run