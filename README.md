# Rick and Morty App

![Flutter](https://img.shields.io/badge/Flutter-3.32.4-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1-blue?logo=dart)

---

## 📃 Descrição

O **Rick and Morty App** é um aplicativo mobile desenvolvido em **Flutter** que consome a API pública do [Rick and Morty](https://rickandmortyapi.com/) para listar e exibir detalhes dos personagens da série.  

O projeto segue a **arquitetura MVVM**, utilizando **injeção de dependências com GetIt**, separando responsabilidades de forma clara e garantindo escalabilidade e manutenção mais simples.  

Possui uma responsividade que adapta espaçamentos, ícones, textos e imagens conforme o tamanho da tela, entregando uma experiência consistente em diferentes dispositivos móveis.

<img src="media/show.gif" alt="Rick and Morty App" width="200"/>

---

## 💻 Tecnologias Utilizadas

- **Flutter** → Framework multiplataforma (Android/iOS).  
- **Dart** → Linguagem de programação.  
- **Dio** → Cliente HTTP para consumo da API.  
- **GetIt** → Injeção de dependências (DI).  
- **ChangeNotifier** → Gerenciamento de estado reativo.  
- **Connectivity Plus** → Verificação de conectividade com a internet.  
- **Arquitetura MVVM** → Separação entre **Model**, **View** e **ViewModel**.  

---

## 🛎️ Funcionalidades

### 🔹 Lista de Personagens
- Consome o endpoint `character` da API.  
- Exibe:
  - **Imagem** do personagem  
  - **Nome**  
  - **Espécie**  
- Suporte a paginação.  
- Ícone de erro exibido em caso de falha no carregamento da imagem.  

### 🔹 Detalhes do Personagem
- Exibe informações detalhadas:
  - Nome  
  - Status  
  - Espécie  
  - Imagem em destaque  

### 🔹 Gerenciamento de Estados
- **Loading** → Indicador de carregamento.  
- **Success** → Dados carregados com sucesso.  
- **Empty** → Nenhum resultado encontrado.  
- **Error** → Erro genérico com retry.  
- **No Connection** → Ausência de conexão com retry.  

### 🔹 Navegação
- Navegação feita com `Navigator` e `NavigationService` (`navigatorKey`).  
- Rotas centralizadas no `AppRouteManager`.  

---

## 📱 Responsividade

- A classe `ResponsivityUtils` adapta:
  - Ícones  
  - Textos  
  - Espaçamentos  
  - Imagens  
- Baseada em `MediaQuery` para diferentes resoluções.  
- Garantindo escalabilidade e experiência consistente.  

---

## ▶️ Como Rodar o Projeto

```bash
# 1. Clone o repositório
git clone https://github.com/seu-user/rick-morthy-app.git
cd rick_morthy_app

# 2. Instale as dependências
flutter pub get

# 3. Rode o app
flutter run
