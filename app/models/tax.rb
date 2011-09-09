# BillGastro -- The innovative Point Of Sales Software for your Restaurant
# Copyright (C) 2011  Michael Franzl <michael@billgastro.com>
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class Tax < ActiveRecord::Base
  has_many :categories
  has_many :items
  has_many :orders
  belongs_to :company

  validates_presence_of :name, :percent
  validates_numericality_of :percent

  include Scope
  include Base
  before_create :set_model_owner

  def custom_name
    @custom_name = percent.to_s + '%, ' + name
  end
  
  def percent=(percent)
      percent = percent.gsub(',', '.') if percent.class == String
      write_attribute(:percent, percent)
  end

end
