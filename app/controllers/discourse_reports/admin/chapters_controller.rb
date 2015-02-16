module DiscourseReports
  class Admin::ChaptersController < ::Admin::AdminController
    def create
      chapter = Chapter.new(chapter_params)
      if chapter.save
        render_serialized(chapter, ChapterSerializer)
      else
        render_json_error(chapter)
      end
    end

    def update
      chapter = Chapter.where(id: params.require(:id)).first
      if chapter.update(chapter_params)
        render_serialized(chapter, ChapterSerializer)
      else
        render_json_error(chapter)
      end
    end

    def destroy
      chapter = Chapter.where(id: params.require(:id)).first
      chapter.destroy if chapter.present?
      render nothing: true
    end

    private

    def chapter_params
      params.require(:chapter).permit(:name, :position, :discourse_reports_part_id)
    end
  end
end
