class Project < ActiveRecord::Base
    extend Slugify::ClassMethods
    include Slugify::InstanceMethods

    validates_presence_of :name, :materials, :image_url, :instructions

    belongs_to :user
end 
