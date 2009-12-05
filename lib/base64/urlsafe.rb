require 'base64'

unless Base64.respond_to?(:urlsafe_encode)
  module Base64
    def self.urlsafe_encode64(bin)
      encode64(bin).tr('+/=', '-_ ').strip.delete("\n")
    end

    def self.urlsafe_decode64(str)
      decode64(str.tr('-_ ', '+/='))
    end
  end
end
