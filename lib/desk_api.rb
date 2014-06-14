module DeskApi
  
  class << self
    attr_accessor :client, :key, :secret, :oauth_token, :oauth_token_secret, :site    
  end

  def self.configure(&block)
    yield self
  end  

  
  class Client
    VALID_REQUEST_METHODS = %w(get post put patch delete head request)
    
    attr_reader :access_token
    
    def initialize
      @access_token = generate_access_token
    end
    
    # delegate to Oauth's AccessToken, make requests with same args
    def method_missing method, *args, &block
      if match = /^#{VALID_REQUEST_METHODS.join("|")}/.match(method.to_s)
        token_method = match[0].to_sym
        access_token.send(token_method, *args, &block)
      else
        raise NoMethodError, "Method not supported on DeskApi client"
      end
      
    end

    # thin wrapper for calling .patch() directly
    def patch(path)
      access_token.request('patch', path, *arguments)
    end 
    

    private
    
    def generate_access_token
      consumer = OAuth::Consumer.new(DeskApi.key, DeskApi.secret, :site => DeskApi.site)
      token    = OAuth::AccessToken.from_hash(consumer, {:oauth_token        => DeskApi.oauth_token, 
                                                         :oauth_token_secret => DeskApi.oauth_token_secret})
    end

    
  end
end
