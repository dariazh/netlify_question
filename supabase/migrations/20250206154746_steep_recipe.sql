/*
  # Seed data for Salt&Pepper Recipe App
  
  1. Categories
  2. Tags
  3. Test user recipes
*/

-- Seed Categories
INSERT INTO categories (name, description, icon) VALUES
('Breakfast', 'Morning meals to start your day', '🍳'),
('Lunch', 'Midday meals and quick bites', '🥪'),
('Dinner', 'Evening meals and hearty dishes', '🍽️'),
('Desserts', 'Sweet treats and baked goods', '🍰'),
('Snacks', 'Light bites and appetizers', '🥨');

-- Seed Tags
INSERT INTO tags (name) VALUES
('Vegetarian'),
('Vegan'),
('Gluten-Free'),
('Quick & Easy'),
('Healthy'),
('Comfort Food'),
('Spicy'),
('Low-Carb');