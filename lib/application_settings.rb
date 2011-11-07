module ApplicationSettings

  def config
    @@config ||= {}
  end

  def config=(hash)
   @@config = hash
  end

  module_function :config=, :config

end