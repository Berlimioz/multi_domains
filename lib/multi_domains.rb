module MultiDomains
  class << self
    attr_accessor :domain_customizable_class, :main_domain_name, :main_domain_extensions

    def domain_customizable_name
      self.domain_customizable_class.to_s.underscore
    end

    def default_domain_regexp
      /#{self.main_domain_name}\.(dev|#{self.main_domain_extension})/
    end
  end
end
