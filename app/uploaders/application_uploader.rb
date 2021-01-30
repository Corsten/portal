class ApplicationUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  GSUB_MODEL_NAME_LETTERS = ['-', '/'].freeze

  storage :file

  def self.prepare_model_name(value)
    value.to_s.tr(*GSUB_MODEL_NAME_LETTERS)
  end

  def self.store_dir
    Pathname.new(ENV.fetch('STORE_PATH', Rails.root + 'public' + 'uploads'))
  end

  def cache_dir
    self.class.store_dir + 'cache'
  end

  def exist?
    model.send("#{mounted_as}?")
  end

  def url_options
    return if file.blank?

    {
      model_name: model.model_name.to_s.underscore.tr(*GSUB_MODEL_NAME_LETTERS.reverse),
      mounted_as: mounted_as.to_s,
      model_id: model.id
    }
  end
end
