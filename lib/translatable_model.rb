require "translatable_model/version"
require "translatable_model/railtie" if defined?(Rails)

module TranslatableModel
  
  class ActiveRecord::Base
  
    class << self
      def translatable(column, option = {})
        # check if coloumn exists
        raise "Column #{column} does not exist in Model #{self.name}" unless self.column_names.include? column.to_s  
        define_method column do
          MyModel.new(column, self)
        end
      end
    end
  
  end
  
  class MyModel < String
    attr_accessor :attributes
    attr_accessor :parent
    attr_accessor :column
    
    def method_missing(method_sym, *args, &block)
      locale = method_sym.to_s.gsub('=', '')
      if I18n.config.available_locales_set.include? locale
        define_attribute(locale)
        send(method_sym, args, block)
      else
        super(method_sym, args, block)
      end
    end
    
    def initialize(column, parent)
      @parent = parent
      @column = column
      while (@attributes = is_json?(parent[column]))==false do
        parent.send(:"#{column}=", {I18n.default_locale => parent[column]}.to_json)
        parent.save
      end
      super(@attributes[I18n.locale.to_s] || "Undefined translation for #{I18n.locale.to_s}")
      
      @attributes.each_key do |locale|
        define_attribute locale
      end
    end
    
    def is_json?(json)
      begin
        return JSON.parse(json)
      rescue Exception => e
        return false
      end
    end
    
    def define_attribute(locale)
      define_singleton_method locale do
        @attributes[locale]
      end
      define_singleton_method "#{locale}=" do |newval|
        @attributes[locale] = newval
        @parent.send("#{@column}=", @attributes.to_json)
      end
    end
  end
  
end
