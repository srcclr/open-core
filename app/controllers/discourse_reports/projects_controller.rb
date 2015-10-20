module DiscourseReports
  class ProjectsController < ::ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def index
      respond_to do |format|
        format.html do
          store_preloaded('projects',  MultiJson.dump(projects))
          render 'default/empty'
        end
        format.json { render_json_dump(projects) }
      end
    end

    private

    def projects
      %w(security-headers csp-reports bughunt-leaderboard).map do |project|
        JSON.parse(Faraday.get("https://api.github.com/repos/srcclr/#{project}?#{auth_params}").body)
      end
    end

    def auth_params
      "client_id=#{SiteSetting.github_client_id}&client_secret=#{SiteSetting.github_client_secret}".freeze
    end
  end
end
