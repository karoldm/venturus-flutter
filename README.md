
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
- SQL para popular o banco de recipes
```
DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS recipes;

-- SUBSTITUIR POR SEU ID em default de user_id!
CREATE TABLE recipes (
    id uuid PRIMARY KEY default gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    ingredients TEXT[] NOT NULL,
    instructions TEXT[] NOT NULL,
    prep_time_minutes INTEGER NOT NULL,
    cook_time_minutes INTEGER NOT NULL,
    servings INTEGER NOT NULL,
    difficulty VARCHAR(50) NOT NULL,
    cuisine VARCHAR(100) NOT NULL,
    calories_per_serving INTEGER NOT NULL,
    tags VARCHAR(255)[],
    user_id uuid default '790e503c-30de-438c-9998-d7183cea4532',
    image VARCHAR(255),
    rating DECIMAL(3, 2),
    review_count INTEGER,
    meal_type VARCHAR(100)
);

-- Inserção de todas as 50 receitas
INSERT INTO recipes (name, ingredients, instructions, prep_time_minutes, cook_time_minutes, servings, difficulty, cuisine, calories_per_serving, tags, image, rating, review_count, meal_type) VALUES
('Classic Margherita Pizza', ARRAY['2 cups pizza dough', '1/2 cup tomato sauce', '2 cups shredded mozzarella cheese', 'Fresh basil leaves', '2 tablespoons olive oil', 'Salt to taste'], ARRAY['Preheat oven to 475°F (245°C).', 'Roll out the pizza dough on a floured surface.', 'Spread tomato sauce evenly over the dough.', 'Sprinkle with mozzarella cheese.', 'Bake for 10-12 minutes until crust is golden.', 'Garnish with fresh basil and drizzle with olive oil.'], 20, 12, 4, 'Easy', 'Italian', 800, ARRAY['italian', 'pizza', 'dinner'], 'https://cdn.dummyjson.com/recipe-images/1.webp', 4.8, 125, 'Dinner'),
('Vegetable Stir Fry', ARRAY['2 cups mixed vegetables (bell peppers, broccoli, carrots)', '2 tablespoons soy sauce', '1 tablespoon ginger, minced', '2 cloves garlic, minced', '1 tablespoon vegetable oil', '1 teaspoon sesame oil'], ARRAY['Heat oils in a wok or large pan.', 'Add ginger and garlic, sauté for 30 seconds.', 'Add vegetables and stir fry for 5-7 minutes.', 'Add soy sauce and cook for another 2 minutes.', 'Serve hot.'], 15, 10, 2, 'Easy', 'Asian', 350, ARRAY['vegetarian', 'quick', 'healthy'], 'https://cdn.dummyjson.com/recipe-images/2.webp', 4.5, 89, 'Lunch'),
('Chocolate Chip Cookies', ARRAY['2 1/4 cups all-purpose flour', '1 teaspoon baking soda', '1 teaspoon salt', '1 cup unsalted butter, softened', '3/4 cup granulated sugar', '3/4 cup packed brown sugar', '2 large eggs', '2 cups chocolate chips'], ARRAY['Preheat oven to 375°F (190°C).', 'Mix flour, baking soda, and salt in a bowl.', 'In another bowl, cream butter and sugars.', 'Beat in eggs one at a time.', 'Gradually add flour mixture, then chocolate chips.', 'Drop by tablespoon onto baking sheets.', 'Bake for 9-11 minutes.'], 20, 10, 24, 'Medium', 'American', 150, ARRAY['dessert', 'baking', 'sweets'], 'https://cdn.dummyjson.com/recipe-images/3.webp', 4.9, 215, 'Dessert'),
('Beef Tacos', ARRAY['1 lb ground beef', '1 packet taco seasoning', '8 taco shells', '1 cup shredded lettuce', '1 diced tomato', '1/2 cup shredded cheddar cheese', '1/4 cup sour cream'], ARRAY['Brown ground beef in a skillet, drain fat.', 'Add taco seasoning and water as directed.', 'Heat taco shells as per package instructions.', 'Fill shells with beef mixture.', 'Top with lettuce, tomato, cheese, and sour cream.'], 10, 15, 4, 'Easy', 'Mexican', 450, ARRAY['mexican', 'dinner', 'quick'], 'https://cdn.dummyjson.com/recipe-images/4.webp', 4.6, 78, 'Dinner'),
('Greek Salad', ARRAY['2 cups chopped romaine lettuce', '1 cucumber, diced', '1 cup cherry tomatoes, halved', '1/2 red onion, sliced', '1/2 cup kalamata olives', '4 oz feta cheese, cubed', '2 tablespoons olive oil', '1 tablespoon lemon juice'], ARRAY['Combine all vegetables in a large bowl.', 'Add olives and feta cheese.', 'Whisk together olive oil and lemon juice.', 'Pour dressing over salad and toss gently.'], 15, 0, 2, 'Easy', 'Greek', 300, ARRAY['vegetarian', 'salad', 'healthy'], 'https://cdn.dummyjson.com/recipe-images/5.webp', 4.7, 64, 'Lunch'),
('Homemade Pancakes', ARRAY['1 1/2 cups all-purpose flour', '3 1/2 teaspoons baking powder', '1 teaspoon salt', '1 tablespoon white sugar', '1 1/4 cups milk', '1 egg', '3 tablespoons butter, melted'], ARRAY['In a large bowl, sift together the flour, baking powder, salt and sugar.', 'Make a well in the center and pour in the milk, egg and melted butter; mix until smooth.', 'Heat a lightly oiled griddle or frying pan over medium-high heat.', 'Pour the batter onto the griddle, using approximately 1/4 cup for each pancake.', 'Brown on both sides and serve hot.'], 10, 15, 4, 'Easy', 'American', 200, ARRAY['breakfast', 'vegetarian'], 'https://cdn.dummyjson.com/recipe-images/6.webp', 4.7, 132, 'Breakfast'),
('Spaghetti Carbonara', ARRAY['1 lb spaghetti', '6 oz pancetta or bacon, diced', '2 cloves garlic, minced', '2 large eggs', '1 cup grated Parmesan cheese', 'Black pepper to taste', 'Salt to taste'], ARRAY['Cook spaghetti according to package directions.', 'While pasta cooks, fry pancetta in a large skillet until crisp.', 'Add garlic and cook for 1 minute.', 'In a bowl, whisk eggs and Parmesan.', 'Drain pasta, reserving 1/2 cup cooking water.', 'Working quickly, mix hot pasta with egg mixture, adding cooking water as needed.', 'Add pancetta and garlic, season with pepper.'], 15, 15, 4, 'Medium', 'Italian', 650, ARRAY['pasta', 'dinner'], 'https://cdn.dummyjson.com/recipe-images/7.webp', 4.8, 98, 'Dinner'),
('Chicken Curry', ARRAY['2 lbs chicken, cut into pieces', '2 onions, chopped', '3 cloves garlic, minced', '1 tablespoon ginger, grated', '2 tablespoons curry powder', '1 can coconut milk', '2 tablespoons vegetable oil'], ARRAY['Heat oil in a large pot over medium heat.', 'Add onions, garlic and ginger; cook until soft.', 'Add curry powder and cook for 1 minute.', 'Add chicken pieces and brown on all sides.', 'Pour in coconut milk and simmer for 30 minutes.', 'Serve with rice.'], 20, 30, 6, 'Medium', 'Indian', 500, ARRAY['indian', 'dinner'], 'https://cdn.dummyjson.com/recipe-images/8.webp', 4.6, 87, 'Dinner'),
('Caesar Salad', ARRAY['1 large romaine lettuce, chopped', '1/2 cup Parmesan cheese, grated', '1 cup croutons', '1/2 cup Caesar dressing', '1 teaspoon Worcestershire sauce', '1 clove garlic, minced'], ARRAY['In a large bowl, combine lettuce, croutons and Parmesan.', 'In a small bowl, whisk together dressing, Worcestershire sauce and garlic.', 'Pour dressing over salad and toss to coat.'], 15, 0, 4, 'Easy', 'American', 350, ARRAY['salad', 'quick'], 'https://cdn.dummyjson.com/recipe-images/9.webp', 4.5, 76, 'Lunch'),
('Beef Burger', ARRAY['1 lb ground beef', '1 egg', '1/4 cup bread crumbs', '1 teaspoon Worcestershire sauce', '4 hamburger buns', 'Lettuce, tomato, onion for serving'], ARRAY['In a bowl, mix beef, egg, bread crumbs and Worcestershire sauce.', 'Form into 4 patties.', 'Grill or fry patties for 4-5 minutes per side.', 'Serve on buns with desired toppings.'], 15, 10, 4, 'Easy', 'American', 600, ARRAY['burger', 'dinner'], 'https://cdn.dummyjson.com/recipe-images/10.webp', 4.7, 112, 'Dinner'),
('Mushroom Risotto', ARRAY['1 1/2 cups Arborio rice', '4 cups chicken stock', '1/2 cup white wine', '1 onion, chopped', '2 cups mushrooms, sliced', '1/2 cup Parmesan cheese, grated', '2 tablespoons butter'], ARRAY['Heat stock in a saucepan and keep warm.', 'In a large pan, sauté onion in butter until soft.', 'Add mushrooms and cook for 5 minutes.', 'Add rice and stir to coat with butter.', 'Add wine and cook until absorbed.', 'Add stock 1/2 cup at a time, stirring constantly.', 'Stir in Parmesan before serving.'], 15, 30, 4, 'Medium', 'Italian', 450, ARRAY['italian', 'vegetarian'], 'https://cdn.dummyjson.com/recipe-images/11.webp', 4.6, 65, 'Dinner'),
('Apple Pie', ARRAY['6 cups apples, peeled and sliced', '3/4 cup sugar', '2 tablespoons flour', '1 teaspoon cinnamon', '1/4 teaspoon nutmeg', '2 pie crusts', '1 tablespoon butter'], ARRAY['Preheat oven to 425°F (220°C).', 'Mix apples with sugar, flour and spices.', 'Line pie plate with one crust.', 'Add apple mixture and dot with butter.', 'Cover with top crust, seal edges and cut slits.', 'Bake for 40-45 minutes.'], 30, 45, 8, 'Medium', 'American', 300, ARRAY['dessert', 'baking'], 'https://cdn.dummyjson.com/recipe-images/12.webp', 4.9, 143, 'Dessert'),
('Chicken Noodle Soup', ARRAY['1 lb chicken, cubed', '8 cups chicken broth', '2 carrots, sliced', '2 celery stalks, sliced', '1 onion, chopped', '2 cups egg noodles', '1 teaspoon thyme'], ARRAY['In a large pot, bring broth to a boil.', 'Add chicken and vegetables, simmer for 20 minutes.', 'Add noodles and cook for 10 more minutes.', 'Season with thyme, salt and pepper.'], 20, 30, 6, 'Easy', 'American', 250, ARRAY['soup', 'comfort food'], 'https://cdn.dummyjson.com/recipe-images/13.webp', 4.7, 98, 'Lunch'),
('Beef Stew', ARRAY['2 lbs beef stew meat', '4 carrots, chopped', '3 potatoes, cubed', '1 onion, chopped', '4 cups beef broth', '2 tablespoons flour', '2 tablespoons tomato paste'], ARRAY['Brown beef in a large pot.', 'Add vegetables and cook for 5 minutes.', 'Stir in flour, then add broth and tomato paste.', 'Simmer for 2 hours until meat is tender.'], 30, 120, 6, 'Medium', 'American', 400, ARRAY['stew', 'comfort food'], 'https://cdn.dummyjson.com/recipe-images/14.webp', 4.8, 87, 'Dinner'),
('Omelette', ARRAY['3 eggs', '1/4 cup milk', '1/2 cup cheese, shredded', '1/4 cup vegetables (optional)', '1 tablespoon butter', 'Salt and pepper to taste'], ARRAY['Beat eggs with milk, salt and pepper.', 'Melt butter in a non-stick pan.', 'Pour in egg mixture and cook over medium heat.', 'When eggs begin to set, add fillings to one half.', 'Fold omelette in half and serve.'], 5, 5, 1, 'Easy', 'French', 300, ARRAY['breakfast', 'quick'], 'https://cdn.dummyjson.com/recipe-images/15.webp', 4.5, 76, 'Breakfast'),
('Garlic Bread', ARRAY['1 French baguette', '1/2 cup butter, softened', '4 cloves garlic, minced', '2 tablespoons parsley, chopped'], ARRAY['Preheat oven to 375°F (190°C).', 'Mix butter, garlic and parsley.', 'Slice bread and spread with butter mixture.', 'Bake for 10 minutes until golden.'], 10, 10, 4, 'Easy', 'Italian', 200, ARRAY['side', 'vegetarian'], 'https://cdn.dummyjson.com/recipe-images/16.webp', 4.6, 54, 'Side'),
('Chocolate Cake', ARRAY['1 3/4 cups flour', '2 cups sugar', '3/4 cup cocoa powder', '1 1/2 teaspoons baking soda', '1 1/2 teaspoons baking powder', '1 teaspoon salt', '2 eggs', '1 cup milk', '1/2 cup vegetable oil', '2 teaspoons vanilla extract', '1 cup boiling water'], ARRAY['Preheat oven to 350°F (175°C).', 'Mix dry ingredients in a large bowl.', 'Add eggs, milk, oil and vanilla; beat for 2 minutes.', 'Stir in boiling water (batter will be thin).', 'Pour into greased pans and bake for 30-35 minutes.'], 20, 35, 12, 'Medium', 'American', 350, ARRAY['dessert', 'baking'], 'https://cdn.dummyjson.com/recipe-images/17.webp', 4.9, 187, 'Dessert'),
('Grilled Salmon', ARRAY['4 salmon fillets', '2 tablespoons olive oil', '1 lemon, juiced', '1 teaspoon dill', 'Salt and pepper to taste'], ARRAY['Preheat grill to medium-high.', 'Brush salmon with oil and lemon juice.', 'Season with dill, salt and pepper.', 'Grill for 4-5 minutes per side.'], 10, 10, 4, 'Easy', 'Mediterranean', 400, ARRAY['seafood', 'healthy'], 'https://cdn.dummyjson.com/recipe-images/18.webp', 4.7, 92, 'Dinner'),
('Vegetable Lasagna', ARRAY['9 lasagna noodles', '2 cups ricotta cheese', '2 cups mozzarella cheese', '1/2 cup Parmesan cheese', '2 cups marinara sauce', '2 cups mixed vegetables (spinach, zucchini, mushrooms)'], ARRAY['Preheat oven to 375°F (190°C).', 'Cook noodles according to package.', 'Layer noodles, ricotta, vegetables and sauce in a baking dish.', 'Repeat layers, ending with mozzarella and Parmesan.', 'Bake for 30 minutes.'], 30, 30, 6, 'Medium', 'Italian', 450, ARRAY['vegetarian', 'pasta'], 'https://cdn.dummyjson.com/recipe-images/19.webp', 4.6, 78, 'Dinner'),
('Banana Bread', ARRAY['3 ripe bananas, mashed', '1/3 cup melted butter', '3/4 cup sugar', '1 egg, beaten', '1 teaspoon vanilla extract', '1 teaspoon baking soda', '1 1/2 cups flour'], ARRAY['Preheat oven to 350°F (175°C).', 'Mix bananas, butter, sugar, egg and vanilla.', 'Add baking soda and flour, stir to combine.', 'Pour into greased loaf pan.', 'Bake for 50-60 minutes.'], 15, 60, 8, 'Easy', 'American', 200, ARRAY['breakfast', 'baking'], 'https://cdn.dummyjson.com/recipe-images/20.webp', 4.8, 134, 'Breakfast');

create table profiles (
  id uuid references auth.users on delete cascade primary key,
  username text unique not null,
  avatar_url text,
  created_at timestamp with time zone default now()
);

create table favorites (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade not null,
  recipe_id uuid references recipes on delete cascade not null,
  created_at timestamp with time zone default now(),
  unique (user_id, recipe_id)
);

-- id VEM DA TABELA auth.users
-- INSERIR SUAS INFORMAÇÕES DE PERFIL
insert into profiles (id, username, avatar_url)
values ('7799c317-7ff5-4eab-a3d8-d147363319cc', 'karoldm', 'https://avatars.githubusercontent.com/karoldm');
```

