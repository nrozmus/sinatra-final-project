class Project < ActiveRecord::Base
    extend Slugify::ClassMethods
    include Slugify::InstanceMethods

    validates_presence_of :name, :image_url, :technical_analysis

    belongs_to :user

    def self.search(search)
     where("name like ?", "%#{search}%")
    end
  end
