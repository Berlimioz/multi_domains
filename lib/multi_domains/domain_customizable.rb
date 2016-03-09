module MultiDomains::DomainCustomizable

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_domain_customizable
      validates :subdomain, presence: true, uniqueness: true, exclusion: { in: %w(www us ca jp) }, format: /\A[a-z\d]+(-[a-z\d]+)*\Z/i
      before_save { |object| object.subdomain = object.subdomain.downcase }
    end
  end

  def default_url_params
    url_params = {domain: domain, host: ENV['HTTP_HOST'], protocol: custom_protocol}
    url_params[:subdomain] = get_subdomain unless get_subdomain.blank?
    url_params
  end

  def custom_protocol
    "http#{ENV['PROTOCOL'] == 'https://' ? 's' : ''}://"
  end

  def domain
    custom_domain.blank? ? "#{MultiDomains.main_domain_name}.#{Rails.env.production? ? MultiDomains.main_extension : 'dev'}" : custom_domain
  end

  def get_subdomain
    if custom_domain.blank?
      read_attribute(:subdomain)
    else
      custom_subdomain.blank? ? "" : custom_subdomain
    end
  end

  def needs_redirect?(domain, subdomain)
    !(self.domain == domain && self.get_subdomain == subdomain)
  end

end
