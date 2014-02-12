module HowitzerStat
  class DataCacher
    HASH_EXAMPLE = [
        {
            feature: {
                name: '...',
                description: '...',
                path_to_file: '...',
                line: 1
            },
            scenarios: [
                {
                    scenario: {name: '...', line: 10},
                    steps: [
                        { text: '...', line: 11, used: 'yes'},
                        { text: '...', line: 12, used: 'no'}
                    ]
                }
            ]
        }
    ]

    include Singleton
    def initialize
      @data = {cucumber: {}, rspec: {}}
      @data[:cucumber].default = {}
      @data[:rspec].default = {}
      @data[:cucumber]['testpage'] = HASH_EXAMPLE
    end

    def page_cached?(page_class, type=:cucumber)
      key = normalize_page_class(page_class)
      @data[type].key? key
    end

    def cached_pages(type=:cucumber)
      @data[type].keys
    end

    def set(page_class, stat, type=:cucumber)
      key = normalize_page_class(page_class)
      @data[type][key] = stat if key
    end

    def get(page_class, type=:cucumber)
      key = normalize_page_class(page_class)
      @data[type][key]
    end

  private

    def normalize_page_class(page_class)
      page_class = page_class.to_s
      if page_class.empty? || page_class.nil?
        nil
      else
        page_class
      end
    end
  end

  def self.data_cacher
    @dc ||= DataCacher.instance
  end
end