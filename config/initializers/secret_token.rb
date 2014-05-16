require 'securerandom'

def secure_token
   token_file = Rails.root.join('.secret')
   if File.exist?(token_file)
      #Use existing
      File.read(token_file).chomp
   else
      #Generate new
      token = SecureRandom.hex(64)
      File.write(token_file, token)
      token
   end
end

RushRankerRails::Application.config.secret_key_base = secure_token