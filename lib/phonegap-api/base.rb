module Phonegap
  class UnsupportedPlatformError < StandardError ; end
  class APIError < StandardError ; end
  
  class Connection
    include HTTMultiParty
    base_uri 'https://build.phonegap.com/api/v1'
    follow_redirects false
    format :json

    def initialize(user, pswd)
      @auth = { :basic_auth => { :username => user, :password => pswd } }
    end
    
    def get(url, options={ :body => nil })
      output = self.class.get(url, @auth.merge!(options))
      check_response!(output).parsed_response
    end
    
    def post(url, body, options={})
      output = self.class.post(url, @auth.merge!({:body => {:data => body}.merge!(options)}) )
      check_response!(output).parsed_response
    end
    
    def put(url, body, options={})
      output = self.class.put(url, @auth.merge!({:body => {:data => body}.merge!(options)}) )
      check_response!(output).parsed_response
    end
    
    def delete(url)
      output = self.class.delete(url, @auth.merge!({ :body => nil }) )
      check_response!(output).parsed_response
    end

    def download(url, localfile, options={ :body => nil })
      File.open(localfile, "w") do |movie|
        movie << self.class.get(url, @auth.merge!(options))
      end
    end
    
    def check_response!(output)
      raise APIError, output['error'] if output['error'].class == String      
      output
    end
  end
end
