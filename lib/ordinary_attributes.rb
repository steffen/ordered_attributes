module ActiveAttributes #:nodoc:
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    
    def attr_order(*attributes)
      class << self
        attr_accessor :original_ordered_attributes

        def ordered_attributes(custom_attributes = nil)
          ordered_attributes = custom_attributes || self.original_ordered_attributes
          attributes = []
          ordered_attributes.each do |attr|
            if childs = self.attribute_childs(attr)
              if childs.is_a? Array
                childs.each do |child|
                  attributes << child
                end
              else
                attributes << childs
              end
            end
          end
          attributes
        end
        
        def attribute_childs(attribute)
          if self.attribute_groups
            if childs = self.attribute_groups[attribute]
              return childs
            end
          end
          attribute
        end
      end

      self.original_ordered_attributes = attributes
      
    end
    
    def attr_groups(groups = {})
      class << self
        attr_accessor :attribute_groups
      end

      self.attribute_groups = groups
      
    end
    
    def attr_from(groups = {})
    end

  end
end

ActiveRecord::Base.send :include, ActiveAttributes