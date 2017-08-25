require 'pg'

TITLES = ["Roasted Brussels Sprouts",
  "Fresh Brussels Sprouts Soup",
  "Brussels Sprouts with Toasted Breadcrumbs, Parmesan, and Lemon",
  "Cheesy Maple Roasted Brussels Sprouts and Broccoli with Dried Cherries",
  "Hot Cheesy Roasted Brussels Sprout Dip",
  "Pomegranate Roasted Brussels Sprouts with Red Grapes and Farro",
  "Roasted Brussels Sprout and Red Potato Salad",
  "Smoky Buttered Brussels Sprouts",
  "Sweet and Spicy Roasted Brussels Sprouts",
  "Brussels Sprouts and Egg Salad with Hazelnuts"]

COMMENTS = [{name: "Brian", content: "I give it a 2", recipe_id: 31}]



def db_connection
  begin
    connection = PG.connect(dbname: "brussels_sprouts_recipes")
    yield(connection)
  ensure
    connection.close
  end
end



db_connection do |conn|
  TITLES.each_with_index {|title, index|
    conn.exec("INSERT INTO recipes (name) VALUES ('#{title}')")
  }
end

db_connection do |conn|
  COMMENTS.each_with_index {|comment, index|
    conn.exec("INSERT INTO comments (name, content, recipe_id) VALUES ('#{comment[:name]}', '#{comment[:content]}', '#{comment[:recipe_id]}')")
  }
end

recipes= nil
comments= nil

db_connection do |conn|
  recipes = conn.exec("SELECT * FROM recipes")
  comments = conn.exec("SELECT * FROM comments")
end

recipes.to_a.each do |recipe|
  puts recipe["name"]
end

comments.to_a.each do |comment|
  puts comment["content"]
end

puts "there are #{recipes.to_a.length} recipes in total"
puts "there are #{comments.to_a.length} comments in total"
