module RailsUpgradeTracker
  ENDPOINT = "https://rubygems.org/api/v1/".freeze
  DATES = {
    old: 366,
    new: 120
  }

  class Base
    attr_accessor :rails_version, :rails_data

    def initialize(rails_version)
      @rails_version = rails_version
      @client = Hurley::Client.new(ENDPOINT)
      gather_rails_data
      @gem_data = []
    end

    def collect_gems_from_gemfile(gemfile_path)
      gemfile_content = File.read(gemfile_path)
      gemfile_parser = Gemnasium::Parser.gemfile(gemfile_content)
      @gemnames = gemfile_parser.dependencies.collect(&:name).reject { |n| n == 'rails'}
    end

    def collect_gem_data
      @gemnames.each(&method(:gather_gem_data))
    end

    def resolve_version_numbers
      @gem_data.each_pair do |gem_name, versions|
        versions.map do |v|
          gem_date = as_date(v['built_at'])
          v['useable'] = in_date_range?(gem_date)
        end
      end
    end

    def in_date_range?(date)
      @today ||= Date.today
      date > @today && date < @today + DATES[:new] || date > @today - DATES[:old]
    end

    private

    def gather_rails_data
      response = @client.get("versions/rails.json")
      @rails_data = JSON.parse(response.body).find { |r| r['number'] == rails_version }
      @rails_data
    end

    def gather_gem_data(gem_name)
      response = @client.get("versions/#{gem_name}.json")
      @gem_data << {gem_name => JSON.parse(response.body)}
    end

    def rails_release_date
      @rails_release_date ||= as_date(@rails_data['built_at'])
    end

    def as_date(date_string)
      Date.parse(date_string)
    end
  end
end
