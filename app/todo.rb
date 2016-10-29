require 'sinatra/base'
require 'active_record'
require 'mysql2'
require 'json'
require 'yaml'

class Todo < Sinatra::Base

  configure do
    config = YAML.load_file(File.join(root_dir, 'config', 'database.yml'))
    ActiveRecord::Base.establish_connection(
      config[rack_env]
    )  
  end

  get '/todos' do
    @todos = Todo.order("created_at DESC").all
    @todos.to_json
  end

  get '/todos/:id' do
    @todo = Todo.find_by(id: params[:id])
    @todo.to_json
  end

  post '/todos/:id/status' do
    data = JSON.parse(request.body.read.to_s)
    todo = Todo.find_by(id: params[:id])
    todo.status = data['status'].to_i
    todo.save

    status 200
  end

end
