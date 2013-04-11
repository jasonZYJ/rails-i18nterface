require_relative '../spec_helper'

describe RailsI18nterface::File do
  describe "write" do
    before(:each) do
      @file = RailsI18nterface::File.new(file_path)
    end

    after(:each) do
      FileUtils.rm(file_path)
    end

    it "writes all I18n messages for a locale to YAML file" do
      @file.write(translations)
      @file.read.should == RailsI18nterface::File.deep_stringify_keys(translations)
    end

    def translations
      {
        :en => {
          :article => {
            :title => "One Article"
          },
          :category => "Category"
        }
      }
    end
  end

  describe "deep_stringify_keys" do
    it "should convert all keys in a hash to strings" do
      RailsI18nterface::File.deep_stringify_keys({
        :en => {
          :article => {
            :title => "One Article"
          },
          :category => "Category"
        }
      }).should == {
        "en" => {
          "article" => {
            "title" => "One Article"
          },
          "category" => "Category"
        }
      }
    end
  end

  def file_path
    File.join(File.dirname(__FILE__), "files", "en.yml")
  end
end
