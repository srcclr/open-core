require "github/markup"

module DiscourseReports
  class ProjectsController < ::ApplicationController
    PROJECTS = %w(security-headers csp-reports bughunt)

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

    def show
      respond_to do |format|
        format.html { render 'default/empty' }
        format.json { render_json_dump(project) }
      end
    end

    private

    def projects(list = PROJECTS)
      list.map do |project|
        json = JSON.parse(Faraday.get("https://api.github.com/repos/srcclr/#{project}?#{auth_params}").body)
        json.merge(
          isCspReports: project == "csp-reports",
          isBughunt: project == "bughunt",
          full_description: full_description
        )
      end
    end

    def auth_params
      "client_id=#{SiteSetting.github_client_id}&client_secret=#{SiteSetting.github_client_secret}".freeze
    end

    def project
      @project ||= projects([params[:id]]).first
    end

    def full_description
      @full_description ||= GitHub::Markup.render("README.md", readme_file.read).html_safe if params[:id].present?
    end

    def readme_file
      open(URI.parse("https://raw.githubusercontent.com/srcclr/#{params[:id]}/master/README.md"))
    end
  end
end
