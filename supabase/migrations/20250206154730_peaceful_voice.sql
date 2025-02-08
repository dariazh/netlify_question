/*
  # Initial Schema Setup for Salt&Pepper Recipe App

  1. New Tables
    - recipes
    - categories
    - favorites
    - user_preferences
    - tags
    - recipe_tags

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

-- Create tables
CREATE TABLE IF NOT EXISTS categories (
    id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name        text NOT NULL,
    description text,
    icon        text NOT NULL,
    created_at  timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS recipes (
    id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    title        text NOT NULL,
    description  text,
    instructions text[] NOT NULL,
    ingredients  jsonb NOT NULL,
    cooking_time integer NOT NULL,
    difficulty   text NOT NULL,
    user_id      uuid REFERENCES auth.users (id) ON DELETE CASCADE,
    category_id  uuid REFERENCES categories (id) ON DELETE SET NULL,
    created_at   timestamptz DEFAULT now(),
    updated_at   timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS favorites (
    id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id    uuid REFERENCES auth.users (id) ON DELETE CASCADE,
    recipe_id  uuid REFERENCES recipes (id) ON DELETE CASCADE,
    created_at timestamptz DEFAULT now(),
    UNIQUE (user_id, recipe_id)
);

CREATE TABLE IF NOT EXISTS user_preferences (
    id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id            uuid REFERENCES auth.users (id) ON DELETE CASCADE UNIQUE,
    diet_type          text,
    cuisine_preferences text[],
    spice_level        text,
    created_at         timestamptz DEFAULT now(),
    updated_at         timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS tags (
    id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name       text NOT NULL UNIQUE,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS recipe_tags (
    recipe_id uuid REFERENCES recipes (id) ON DELETE CASCADE,
    tag_id    uuid REFERENCES tags (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, tag_id)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_categories_name ON categories(name);
CREATE INDEX IF NOT EXISTS idx_recipes_title ON recipes(title);
CREATE INDEX IF NOT EXISTS idx_recipes_user_id ON recipes(user_id);
CREATE INDEX IF NOT EXISTS idx_recipes_category_id ON recipes(category_id);
CREATE INDEX IF NOT EXISTS idx_recipes_difficulty ON recipes(difficulty);
CREATE INDEX IF NOT EXISTS idx_user_preferences_diet_type ON user_preferences(diet_type);
CREATE INDEX IF NOT EXISTS idx_tags_name ON tags(name);
CREATE INDEX ON recipe_tags (recipe_id);
CREATE INDEX ON recipe_tags (tag_id);

-- Enable RLS
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipes ENABLE ROW LEVEL SECURITY;
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipe_tags ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Categories are viewable by everyone" 
    ON categories FOR SELECT 
    TO authenticated 
    USING (true);

CREATE POLICY "Users can view all recipes" 
    ON recipes FOR SELECT 
    TO authenticated 
    USING (true);

CREATE POLICY "Users can create recipes" 
    ON recipes FOR INSERT 
    TO authenticated 
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own recipes" 
    ON recipes FOR UPDATE 
    TO authenticated 
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own recipes" 
    ON recipes FOR DELETE 
    TO authenticated 
    USING (auth.uid() = user_id);

CREATE POLICY "Users can view their own favorites" 
    ON favorites FOR SELECT 
    TO authenticated 
    USING (auth.uid() = user_id);

CREATE POLICY "Users can add favorites" 
    ON favorites FOR INSERT 
    TO authenticated 
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can remove their own favorites" 
    ON favorites FOR DELETE 
    TO authenticated 
    USING (auth.uid() = user_id);

CREATE POLICY "Users can view their own preferences" 
    ON user_preferences FOR SELECT 
    TO authenticated 
    USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their preferences" 
    ON user_preferences FOR ALL 
    TO authenticated 
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Tags are viewable by everyone" 
    ON tags FOR SELECT 
    TO authenticated 
    USING (true);

CREATE POLICY "Recipe tags are viewable by everyone" 
    ON recipe_tags FOR SELECT 
    TO authenticated 
    USING (true);