module DiscourseReports
  module Admin
    class PartsController < ::Admin::AdminController
      before_action :find_part, only: %i(update destroy)
      after_action :update_part_constraints, only: %i(create update destroy)

      def index
        parts = Part.order('position').includes(chapters: :topics).all
        render_serialized(parts, PartSerializer)
      end

      def create
        part = Part.new(part_params)
        if part.save
          render_serialized(part, PartSerializer)
        else
          render_json_error(part)
        end
      end

      def update
        if @part.update(part_params)
          render_serialized(@part, PartSerializer)
        else
          render_json_error(@part)
        end
      end

      def destroy
        @part.destroy
        render nothing: true
      end

      private

      def find_part
        @part = Part.find(params.require(:id))
      end

      def part_params
        params.require(:part).permit(:name, :position, :description)
      end

      def update_part_constraints
        Part.update_part_constraints
      end
    end
  end
end
