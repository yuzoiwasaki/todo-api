# encoding: utf-8
require 'spec_helper'

describe Todo do
  def app
    @app = TodoApi
  end

  it '個別TODO情報を取得できる' do
    @todo = FactoryGirl.create(:todo)
    get "/todos/#{@todo.id}"
    json = JSON.parse(last_response.body)
    expect(json['title']).to eq(@todo.title)
    expect(json['description']).to eq(@todo.description)
    expect(json['status']).to eq(@todo.status)
  end

  it '一覧TODO情報を取得できる' do
    10.times { FactoryGirl.create(:todo) }
    get "/todos"
    json = JSON.parse(last_response.body)
    expect(json.count).to eq 10
  end

  it 'TODOタスクのstatusを変更できる' do
    @todo = FactoryGirl.create(:todo)
    post "/todos/#{@todo.id}/status", '{"status": 1}'
    updated_status = Todo.find_by(id: @todo.id).status
    expect(updated_status).to eq 1
  end

  it '新しくTODOタスクを登録できる' do
    expect {
      post "/todos", '{"title": "foo", "description": "bar"}'
    }.to change{Todo.count}.from(0).to(1)
  end
end
