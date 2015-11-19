module DiscourseReports
  class PartChapterTopicConstraint
    THREE_NON_ALPHA = /[a-zA-Z_-]{3,}/
    KEYWORDS = %w(users admin edit create update tags projects rails nwslttr newsletters)
    KEYWORD = /#{KEYWORDS.join("|")}/

    def matches?(request)
      params_are_valid?(request.params)
    end

    private

    def params_are_valid?(params)
      param_valid?(params['part_slug']) &&
      param_valid?(params['chapter_slug']) &&
      param_valid?(params['topic_slug'])
    end

    def param_valid?(param)
      !(param =~ KEYWORD) && !!(param =~ THREE_NON_ALPHA)
    end
  end
end
