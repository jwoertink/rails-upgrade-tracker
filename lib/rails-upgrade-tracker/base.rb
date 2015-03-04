module RailsUpgradeTracker
  ENDPOINT = "https://rubygems.org/api/v1/"

  class Base
    attr_accessor :rails_version, :rails_data

    def initialize(rails_version)
      @rails_version = rails_version
      @client = Hurley::Client.new(ENDPOINT)
      gather_rails_data
    end

    def collect_gems_from_gemfile(gemfile_path)
      gemfile_content = File.read(gemfile_path)
      gemfile_parser = Gemnasium::Parser.gemfile(gemfile_content)
      @gemnames = gemfile_parser.dependencies.collect(&:name).reject { |n| n == 'rails'}
    end

    private

    def gather_rails_data
      response = @client.get("versions/rails.json")
      @rails_data = JSON.parse(response.body).find { |r| r['number'] == rails_version }
      @rails_data
    end
  end
end
