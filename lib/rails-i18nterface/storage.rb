# encoding: utf-8

module RailsI18nterface
  class Storage

    include Utils

    attr_accessor :locale

    def initialize(locale)
      self.locale = locale.to_sym
    end

    def write_to_file
      Yamlfile.new(file_path).write(remove_blanks(keys))
    end

    def self.root_dir
      Rails.root
    end

    private

    def keys
      { locale => I18n.backend.send(:translations)[locale] }
    end

    def file_path
      File.join(self.class.root_dir, 'config', 'locales', "#{locale}.yml")
    end
  end
end