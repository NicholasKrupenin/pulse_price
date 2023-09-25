class PathAnalysis
  CUSTOM_VERB = %w[add edit].freeze

  def initialize
    @valid_path = /\A[\wа-яА-Я]+\z/
  end

  def explore_path(request)
    segments = request.path.split('/').compact_blank
    valid_segments = segments.reject { |segment| CUSTOM_VERB.include?(segment) }
    valid_segments.last unless valid_segments.empty?
  end

  def matches?(request)
   segments = request.path.split('/').compact_blank
   valid_segments = segments.reject { |segment| CUSTOM_VERB.include?(segment) }
   valid_segments.empty? || valid_segments.last.match?(@valid_path)
  end
end
