module MultiDomains::DomainHandler

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def handle_multiple_domains
      define_method("current_#{MultiDomains.domain_customizable_name}") do
        @current_object
      end

      if MultiDomains.force_redirect_to_https?
        before_filter :redirect_to_https
      end

      before_filter :fetch_current_object
      before_filter :redirect_to_standard
      helper_method "current_#{MultiDomains.domain_customizable_name}"
    end
  end

  def redirect_to_https
    if MultiDomains.protocol == 'https://' && request.protocol != MultiDomains.protocol
      redirect_to request.url.gsub!('http', 'https')
    end
  end

  def redirect_to_standard
    obj = self.send("current_#{MultiDomains.domain_customizable_name}")
    if obj.present? && obj.needs_redirect?(request.domain, request.subdomain)
      redirect_options = {status: :moved_permanently}
      redirect_options.merge!(obj.try(:default_url_params)).merge!(params: request.query_parameters)
      flash.keep if respond_to?(:flash)
      redirect_to redirect_options
    end
  end

  def subdomain?
    MultiDomains.default_domain == request.domain and request.subdomain.present?
  end

  def custom_domain?
    MultiDomains.default_domain != request.domain
  end

  def fetch_current_object
    if custom_domain?
      find_by_params = {
        custom_domain: request.domain
      }
      find_by_params[:custom_subdomain] = request.subdomain unless request.subdomain.blank?

      @current_object ||= MultiDomains.domain_customizable_class.find_by(find_by_params)
    elsif subdomain?
      @current_object ||= MultiDomains.domain_customizable_class.find_by(subdomain: request.subdomain)
    end
  end

end
