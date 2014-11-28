module DiscourseReports
  module Topics
    class ArchetypesController < ::ApplicationController
      before_action :find_and_authorize_topic

      def update
        @topic.update_attributes(archetype: archetype)

        render nothing: true
      end

      def destroy
        @topic.update_attributes(archetype: Archetype.default)

        render nothing: true
      end

      private

      def archetype
        Archetype.find(params[:id]) ? params[:id] : Archetype.default
      end

      def find_and_authorize_topic
        @topic = Topic.find_by(id: params[:topic_id].to_i)
        guardian.ensure_can_moderate!(@topic)
      end
    end
  end
end
