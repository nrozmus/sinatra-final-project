class Project < ActiveRecord::Base
    extend Slugify::ClassMethods
    include Slugify::InstanceMethods

    validates_presence_of :pair, :image_url, :technical_analysis

    belongs_to :user
end
