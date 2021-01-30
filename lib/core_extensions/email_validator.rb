module CoreExtensions
  module EmailValidator
    DEFAULT_HIGH_LEVEL_DOMAIN_MIN_LENGTH = 2

    private_constant :DEFAULT_HIGH_LEVEL_DOMAIN_MIN_LENGTH

    private

    def email_domain_syntax_valid?(domain)
      parts = email_domain_parts(domain)

      return false unless valid_high_level_domain_length?(parts[-1])
      super
    end

    def valid_high_level_domain_length?(high_domain)
      return true if options[:high_domain_min_length].blank?
      min_length = options[:high_domain_min_length] || DEFAULT_HIGH_LEVEL_DOMAIN_MIN_LENGTH
      high_domain.length >= min_length
    end

    def email_domain_parts(domain)
      # NOTE: https://github.com/kaize/validates/blob/master/lib/email_validator.rb#L34
      domain.reverse.downcase.gsub(/(?:^\[(.+)\]$)/, '\1').split('.', -1)
    end
  end
end
