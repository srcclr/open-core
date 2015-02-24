module DiscourseReports
  class OpenEventsController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    FIELDS = 'name,group'
    DEFAULT = { fields: FIELDS }

    WHITELIST = %w(lat lon radius time)

    def index
      events = Meetup::OpenEvent.all(events_params)

      respond_to do |format|
        format.html do
          store_preloaded('meetup_open_events', MultiJson.dump(events))
          render 'default/empty'
        end

        format.json { render_json_dump(events) }
      end
    end

    private

    def events_params
      DEFAULT.merge(coordinates)
             .merge(params.slice(*WHITELIST))
    end

    def coordinates
      if params["lat"] && params["lon"]
        {}
      else
        Geoip.coordinates(request.remote_ip)
      end
    end
  end
end
