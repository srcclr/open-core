SuggestedTopicsBuilder.class_eval do
  alias_method :original_initialize, :initialize
  alias_method :original_add_results, :add_results

  def initialize(topic)
    @archetype = topic.archetype
    original_initialize(topic)
  end


  def add_results(results, priority=:low)
    return unless results

    if @archetype.eql?('blog')
      results = results.where(category_id: @category_id)
    end

    original_add_results(results, priority)
  end
end
