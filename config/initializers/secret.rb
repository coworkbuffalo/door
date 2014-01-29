module Door
  def self.config
    @config ||= YAML.load_file("config/secret.yml")
  end
end
