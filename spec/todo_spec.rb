require 'spec_helper'

describe 'GET /todos/:id' do

  def app
    @app = TodoApi
  end

  before do
    @todo = FactoryGirl.create(:todo)
    get "/todos/#{@todo.id}"
  end

  it '200 OK が返ってくる' do
    expect(last_response.status).to eq 200
  end

  it 'TODO情報を取得できる' do
    json = JSON.parse(last_response.body)
    expect(json['title']).to eq(@todo.title)
    expect(json['description']).to eq(@todo.description)
    expect(json['status']).to eq(@todo.status)
  end
end
