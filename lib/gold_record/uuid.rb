require 'securerandom'

module GoldRecord
  module UUID
    def self.random_generate
      bin = SecureRandom.random_bytes(16)
      # Set version 4
      bin[6] &= 0b01001111
      bin[6] |= 0b01000000
      # Set reserved bits
      bin[8] &= 0b10111111
      bin[8] |= 0b10000000
      bin
    end
  
    def self.coerce(value)
      return nil unless value.kind_of?(String)
      if value.size == 22
        value = urlsafe_decode64(value)
      elsif value.size == 32 || value.size == 36
        value = decode_hex(value)
      end
      value = nil unless value.size == 16
      value
    end
  
    def self.encode_hex(bin)
      bin.unpack("H*").first
    end
  
    def self.decode_hex(str)
      [str.delete("-")].pack("H*")
    end

    # Slightly modified backport from Ruby 1.9
    # http://www.ruby-doc.org/ruby-1.9/classes/Base64.html
    # Strips padding char (=) and newlines from end of encoded string.
  
    def self.urlsafe_encode64(bin)
      [bin].pack("m").tr("+/=", "-_ ").strip.delete("\n")
    end

    def self.urlsafe_decode64(str)
      "#{str.tr("-_", "+/")}===".unpack("m").first
    end
  end
end
