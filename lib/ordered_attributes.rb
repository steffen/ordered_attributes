module OrderedAttributes #:nodoc:
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    
    def attr_order(*attributes)
      class << self
        attr_accessor :default_ordered_attributes

        def ordered_attributes(*custom_attributes)
          ordered_attributes = custom_attributes.flatten.empty? ? self.default_ordered_attributes : custom_attributes.flatten
          attributes = []
          ordered_attributes.each do |attribute|
            attribute = attribute.to_sym
            if self.respond_to?(:attribute_groups) && childs = self.attribute_groups[attribute]
              attributes.concat(self.ordered_attributes(childs))
            else
              attributes << attribute
            end
          end
          attributes
        end
      end

      self.default_ordered_attributes = attributes.flatten
      
    end
    
    def attr_groups(groups = {})
      class << self
        attr_accessor :attribute_groups
      end

      self.attribute_groups = groups
      
    end

  end
end

ActiveRecord::Base.send :include, OrderedAttributes