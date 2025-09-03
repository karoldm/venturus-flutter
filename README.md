
# Trilha Flutter - Venturus 

Projeto desenvolvido durante o módulo de Flutter do [Programa de Capacitação em Desenvolvimento Android e Multiplataforma Flutter](https://www.venturus.org.br/capacitacao-em-desenvolvimento-android) da [Venturus](https://www.venturus.org.br/)

O projeto teve o objetivo de colocar em prática os fundamentos do Flutter e aprofundar em temas como testes, arquitetura, integrações e animações. 

## Tópicos abordados:
- **Fundamentos do Dart**
  - Variáveis
  - Tipagem forte e dinâmica
  - Fluxos de controle
  - Collections (listas, maps, etc.)
  - Classes e objetos (OOP)
- **Fundamentos do Flutter**
  - O que são widgets e os tipos (Stateless e Stateful)
  - Estados e mudanças de estado (setState)
  - Catálogo de widgets do Flutter 
  - Criação de widgets customizáveis 
  - pubspec (dependencias e configurações) 
  - Theme e ThemeData
- **Integrações**
  - Integração com [Supabase](https://supabase.com/) 
  - Fetch para requisições https
  - Conexão com banco de dados e queries 
- **Arquitetura**
  - MVVM para organizar o projeto 
  - Injeção de dependencia para services, repositories e viewModels 
  - Separação do projeto em camada de dados e camada de UI 
    - Camada de dados 
      - Model para definir as entidades 
      - Repositories para buscar os dados e tratar regras de negócio 
      - Services para buscar os dados brutos da API (supabase)
    - Camada de UI
      - Uma pasta por tela dividida em view (definição dos widgets) e viewModel (controle de estados e regras de negócio)
      - pasta /widgets para widgets customizáveis ou usados na aplicação toda 
- **Pacotes**
  - Injeção de dependencias usando o [GetIt](https://pub.dev/packages/get_it)
  - Controle de estado e reatividade usando o [GetX](https://pub.dev/packages/get)
  - Roteamento com [GoRouter](https://pub.dev/packages/go_router)
  - Tratamento de errors com [Either](https://pub.dev/packages/either_dart)
  - Internacionalização com [intl](https://pub.dev/packages/intl)
  - Variáveis de ambiente com [flutter dotenv](https://pub.dev/packages/flutter_dotenv)
  - Armazenamento local com [sqflite](https://pub.dev/packages/sqflite)
- **Testes**
  - Testes de unidade 
  - Testes de integração 
    - setUpAll 
    - setUp
    - provideDummy
    - tearDown 
    - group e test 
    - expect
  - Testes de widget 
    - testWidgets 
    - pumpWidget 
    - pumpAndSettle 
    - verify


## Projetos Desenvolvidos

Quatro projetos foram desenvolvidos durante as aulas:
- **/raffle**: sorteador para abordar tópicos como widgets stateful e estados no Flutter
- **/tv_shows**: listagem de filmes com dados mockados. O projeto abordou tópicos como Widgets de lista e grid, mudanças de estado, temas customizáveis e mudança de tema e roteamento.
- **/tv_shows_api**: listagem de filmes com consumo de dados de uma API pública. O projeto abordou tópicos como fetch, operações async e armazenamento local para persistir filmes favoritos.
- **/recipes**: Aplicativo de receitas com integração com o Supabase. Abordou tópicos como integrações, queries em banco de dados, autenticação (supabase auth), testes, Internacionalização, configuração e build do projeto para Android. 

## Informações Adicionais
- Flutter versão `3.24.5`
- Exemplo de .env para recipes:
```
SUPABASE_URL=https://projeto_key.supabase.co
SUPABASE_ANON_KEY=ANON_KEY
```

