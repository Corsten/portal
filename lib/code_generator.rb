module CodeGenerator
  module_function

  def random_token
    SecureRandom.alphanumeric configus.token.length
  end

  def numeric(len)
    min = 10**(len - 1)
    max = 10**len - 1
    rand(min..max)
  end
end
