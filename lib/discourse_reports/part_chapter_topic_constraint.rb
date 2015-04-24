module DiscourseReports
  class PartChapterTopicConstraint
    NOT_ONLY_A_NUMBER = /.*[a-zA-Z_-]{3,}.*/
    KEYWORDS = /users|admin|edit|create|update/

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
      !(param =~ KEYWORDS) && !!(param =~ NOT_ONLY_A_NUMBER)
    end
  end
end
