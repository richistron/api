class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  belongs_to :tenant
  validates_presence_of :tenant
end
