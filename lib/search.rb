Search.class_eval do
  alias_method :original_execute, :execute
  alias_method :original_initialize, :initialize

  def initialize(term, opts=nil)
    pattern = /tags:([\w+,]+)/
    if Topic.instance_methods.include?(:tags) && term =~ pattern
      @tags = $1
      term.gsub!(pattern, '')
    end

    original_initialize(term, opts)
  end

  def execute
    @results = original_execute()
    if @results && @results.posts && @tags
      @results.posts.reject! { |post| ((post.topic.tags || []) & @tags.split(',')).empty? }
    end

    @results
  end
end
