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

  get '/todos/:id/:status' do
    if params[:status] =~ /status=(\d)/
      request_status = $1
    end
    todo = Todo.find_by(id: params[:id])
    todo.status = request_status.to_i
    todo.save
  end

end
