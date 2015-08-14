module DiscourseReports
  module Admin
    class ChaptersController < ::Admin::AdminController
      before_action :find_chapter, only: %i(update destroy)

      def create
        chapter = Chapter.new(chapter_params)

        if chapter.save
          render_serialized(chapter, ChapterSerializer)
        else
          render_json_error(chapter)
        end
      end

      def update
        if @chapter.update(chapter_params)
          render_serialized(@chapter, ChapterSerializer)
        else
          render_json_error(@chapter)
        end
      end

      def destroy
        @chapter.destroy
        render nothing: true
      end

      private

      def find_chapter
        @chapter = Chapter.find(params.require(:id))
      end

      def chapter_params
        params.require(:chapter).permit(:name, :position, :discourse_reports_part_id)
      end
    end
  end
end
