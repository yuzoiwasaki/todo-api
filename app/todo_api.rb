require 'sinatra/base'
require 'active_record'
require 'mysql2'
require 'json'
require 'yaml'
require_relative 'models/todo'

class TodoApi < Sinatra::Base

  configure do
    root_path = File.expand_path(File.join(root, '..'))
    config = YAML.load_file(File.join(root_path, 'config', 'database.yml'))
    ActiveRecord::Base.establish_connection(
      config[ENV['RACK_ENV']]
    )  
  end

  get '/todos' do
    todos = Todo.order("created_at DESC")
    todos.to_json
  end

  get '/todos/:id' do
    todo = Todo.find_by(id: params[:id])
    todo.to_json
  end

  post '/todos/:id/status' do
    data = JSON.parse(request.body.read.to_s)
    if data['status'].to_s == '0' || data['status'].to_s == '1'
      todo = Todo.find_by(id: params[:id])
      todo.status = data['status'].to_i
      todo.save

      "ステータスを更新しました"
    else
      "リクエストが不正です"
    end
  end

  get '/*' do
    'The page you were looking for doesn\'t  exist.'
  end
end
