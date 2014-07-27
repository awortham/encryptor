class Encryptor

  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.to_a.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(message, rotation)
    letters = message.split("")

    #results = []
    #letters.collect do |letter|
      #encrypted_letter = encrypt_letter(letter,rotation)
      #results.push(encrypted_letter)
    #end

    results = letters.map do |letter|
      encrypt_letter(letter, rotation)
    end

    encrypted_message = results.join

  end

  def decrypt(encrypted_message, rotation)
    encrypt(encrypted_message,-rotation)
  end

  def multiple_encryption(string,rotations)
    multiple = string.split("").each
    results = []
    while true
      begin
        rotations.each do |rotation|
          encrypted_letter = encrypt_letter(multiple.next,rotation)
          results.push(encrypted_letter)
        end
      rescue StopIteration
        break results.join
      end
    end
    #assign letters to the correct position and rotation
    #could do it with 2 rotations divided between the even and odd numbers
  end

  def encrypt_file(filename, rotation)
    input = File.read(filename)

    secret = encrypt(input, rotation)

    File.open(filename, "w") do |file|
      file.write(secret)
    end
  end


  def decrypt_file(filename, rotation)
    encrypt_file(filename, -rotation)
  end

  def supported_characters
     (' '..'z').to_a
  end

  def crack(encrypted_message)
    # support_characters => [ "!", "#", "&"]
    # supported_characters.count => 91
    # supported_characters.count.times
    supported_characters.count.times.collect do |rotation|
      decrypt(encrypted_message, rotation)
    end
  end
end
