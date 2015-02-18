module DiscourseReports
  class CommunitiesController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    FIELDS = 'name,members,lat,lon,link'
    DEFAULT = { fields: FIELDS, lat: 47.6097, lon: -122.3331 }

    WHITELIST = %w(lat lon radius)

    def index
      groups = Meetup::Group.all(group_params)

      respond_to do |format|
        format.html do
          store_preloaded('meetup_groups', MultiJson.dump(groups))
          render 'default/empty'
        end

        format.json { render_json_dump(groups) }
      end
    end

    private

    def group_params
      DEFAULT.merge(params.slice(WHITELIST))
    end
  end
end
