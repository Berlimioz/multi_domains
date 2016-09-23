require 'multi_domains/version'
require 'multi_domains/domain_customizable'
require 'multi_domains/domain_handler'

module MultiDomains
  class << self
    attr_accessor :domain_customizable_class_name, :protocol, :force_redirect_to_https, :default_domain

    def force_redirect_to_https?
      force_redirect_to_https
    end

    def domain_customizable_name
      domain_customizable_class_name.underscore
    end
  end
end
