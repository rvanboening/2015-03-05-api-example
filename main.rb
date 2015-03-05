require "sinatra"
require 'json'
require "sqlite3"

DATABASE = SQLite3::Database.new("students.db")
DATABASE.results_as_hash = true

require_relative "student"

get "/" do
  erb :homepage
end

get "/students" do
  students = Student.all
  
  students_hash = students.map {|s| s.to_hash}
  students_hash.to_json
end

get "/students/:id/new_name/:newname" do
  id = params[:id].to_i
  name = params[:newname]
  student = Student.new({"id" => id, "name" => name})
  student.edit_student_name
end

get "/students/:id" do
  student = Student.find(params[:id])

  student.edit_student_name
  student_hash.to_json
end

get '/new_student/name/:name/age/:age/github/:github' do
  name = params[:name]
  age = params[:age].to_i
  github = params[:github]
  student = Student.new({"name" => name, "age" => age, "github" => github})
  student.insert
  redirect to("/")
end

get '/delete_student/id/:id' do
  id = params[:id]
  student=Student.new({"id" => id})
  student.delete
  redirect to("/")
end

get '/is_wise/id/:id' do
  student = Student.find(params[:id])
  student.ultra_wise? ? "yes" : "no"  # another way to write an if else statement.
end

get '/can_drink/id/:id' do
  student = Student.find(params[:id])
  student.can_drink? ? "yes" : "no"
end

get '/drink_wise/id/:id' do
  student = Student.find(params[:id])
  drink = student.can_drink? ? "yes" : "no"
  wise = student.ultra_wise? ? "yes" : "no"
  student_hash={"name" => student.name, "github" => student.github, "drink" => drink, "wise" => wise}
  student_hash.to_json  
end


# Afternoon Assignment:

# - Add a route that modifies a student record. There's no need for a page that shows a form for editing. We're just working with request paths directly. (Use 'get' instead of 'post' to make it easier to check that things work. Once it's working, change it to 'post'.)

# - Add routes for creating and deleting students, too.

# - Add a route that returns if a particular student is ultra wise. And one for whether the student can drink.

# - Change the application as needed so that the routes I wrote above return whether students can drink, whether they're ultra wise, and their GitHub *link* in the JSON response.

# From the console, you should be able to use `XMLHttpRequest` to make requests to these paths and parse the responses as JSON, just like we went over together.

## DOM Exercises

# - Add links to various routes on the homepage.
# - Clicking a link should create an `XMLHttpRequest` to that path.
# - Display the result in some elegant way in an alert to the user.
# - Change your code so that the result displays on the page somewhere instead.
# - Some of the routes above change information in the database and therefore need user-submitted information. Those are harder to implement, so save them as a bonus for the end. (Look into FormData.)