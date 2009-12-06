module GoldRecord
  # Slightly modified backport from Ruby 1.9
  # http://www.ruby-doc.org/ruby-1.9/classes/Base64.html
  # Strips padding char (=) and newlines from end of encoded string.
  
  def self.urlsafe_encode64(bin)
    [bin].pack("m").tr("+/=", "-_ ").strip.delete("\n")
  end

  def self.urlsafe_decode64(str)
    "#{str.tr("-_", "+/")}===".unpack("m0").first
  end
end
