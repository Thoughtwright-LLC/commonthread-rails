class Encrypter
  def self.encrypt(input)
    return nil if input.nil?
    Base64.encode64(self.blowfish.encrypt_string(input))
  end

  def self.decrypt(input)
    return nil if input.nil?
    self.blowfish.decrypt_string(Base64.decode64(input))
  end

  def self.salt
    @@salt || 'common-salt'
  end

  def self.salt=(value)
    @@salt = value
  end

  private

  def self.blowfish
    @@blowfish ||= Crypt::Blowfish.new(self.salt)
  end
end
