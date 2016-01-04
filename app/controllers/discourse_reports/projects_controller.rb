require "github/markup"

module DiscourseReports
  class ProjectsController < ::ApplicationController
    PROJECTS = %w(security-headers csp-reports bughunt ssl-reminder)
    PLUGIN_NAMES = %w(headlines csp-reports leaderboard ssl-reminder)
    REQUIRED_GITHUB_FIELDS = %w(name description forks_count stargazers_count html_url)

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
        json = github_info(project).slice(*REQUIRED_GITHUB_FIELDS)
        json.merge(
          is_csp_reports: project == "csp-reports",
          is_bughunt: project == "bughunt",
          is_ssl_reminder: project == "ssl-reminder",
          is_plugin_installed: plugin_installed?(project)
        )
      end
    end

    def project
      @project ||= projects([params[:id]]).first
    end

    def github_info(project)
      JSON.parse(Faraday.get("https://api.github.com/repos/srcclr/#{project}?#{auth_params}").body)
    end

    def auth_params
      "client_id=#{SiteSetting.github_client_id}&client_secret=#{SiteSetting.github_client_secret}".freeze
    end

    def plugin_installed?(project)
      installed_plugins.include?(PLUGIN_NAMES[PROJECTS.index(project)])
    end

    def installed_plugins
      Discourse.plugins.map(&:metadata).map(&:name)
    end
  end
end
