module Phonegap
  
  class Connection
    def create_app(params, options={})
      self.post("/apps", params, options)
    end

    def update_app(app_id, options={})
    	self.post("/apps/#{app_id}", params, options)
    end
    
    def delete_app(app_id, options={})
      self.delete("/apps/#{app_id}", options)
    end
  end
end

