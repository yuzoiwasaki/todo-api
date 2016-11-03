# encoding: utf-8
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
    # ステータス 0:未完了/1:完了、それ以外は不正なリクエストとみなす
    if %w(0 1).include?(data['status'].to_s)
      todo = Todo.find_by(id: params[:id])
      return "TODOタスクが見つかりません" if todo.nil?
      todo.status = data['status'].to_i
      todo.save
      'ステータスを更新しました'
    else
      'リクエストが不正です'
    end
  end

  post '/todos' do
    begin
      data = JSON.parse(request.body.read.to_s)
      todo = Todo.new
      todo.title = data['title']
      todo.description = data['description']
      todo.status = 0
      todo.save!
      res = {"id": todo.id, "msg": "タスクの作成が完了しました"}
      res.to_json
    rescue ActiveRecord::RecordInvalid => e
      e.message
    end
  end

  get '/*' do
    'ページが見つかりません'
  end
end
