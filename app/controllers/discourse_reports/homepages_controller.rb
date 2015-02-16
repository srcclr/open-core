module DiscourseReports
  class HomepagesController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      serialized = serialize_data(topics, TopicHomepageSerializer)

      respond_to do |format|
        format.html do
          store_preloaded('homepage_topics',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

    private

    def top_topics
      Topic
        .joins(:top_topic, :category)
        .where('top_topics.yearly_score > 0')
        .where(categories: { name: SiteSetting.parent_categories.split('|') })
    end

    def topics
      Topic
        .includes(:category)
        .select('*')
        .from(Arel.sql("(#{ranked_topics_query}) AS ranked_topics"))
        .unscope(:where)
        .where('topic_rank <= 3')
    end

    def ranked_topics_query
      top_topics
        .select(<<-SQL).to_sql
          topics.*, row_number() OVER (
            PARTITION BY topics.category_id
            ORDER BY top_topics.yearly_score DESC
          ) AS topic_rank
      SQL
    end
  end
end
