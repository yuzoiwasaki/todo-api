# encoding: utf-8
require 'active_record'

class Todo < ActiveRecord::Base
  validates :title, presence: true
end
