require 'multi_domains/domain_customizable'
require 'multi_domains/domain_handler'

module MultiDomains
  class << self
    attr_accessor :domain_customizable_class, :protocol, :force_redirect_to_https, :default_domain

    def force_redirect_to_https?
      force_redirect_to_https
    end

    def domain_customizable_name
      self.domain_customizable_class.to_s.underscore
    end

    def default_domain_regexp
      /#{self.main_domain_name}\.(dev|#{self.main_domain_extension})/
    end
  end
end
