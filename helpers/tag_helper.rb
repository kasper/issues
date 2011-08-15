module TagHelper

  module Helpers
  
    def tag_popularity_class(tag)
    
      if tag.popularity <= 0.25
        "small-popularity"
      elsif tag.popularity <= 0.5
        "medium-popularity"
      elsif tag.popularity <= 0.75
        "large-popularity"
      else
        "vast-popularity"
      end
      
    end
  
  end
  
  def self.registered(app)
    app.helpers TagHelper::Helpers
  end

end