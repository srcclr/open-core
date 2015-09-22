module DiscourseReports
  class CspReportsController < ::ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    def create
      logger.info(parsed_report)
      head :ok
    end

    private

    def logger
      @logger ||= Logger.new(logfile)
    end

    def logfile
      file = File.open("#{Rails.root}/log/csp_reports.log", 'a')
      file.sync = true
      file
    end

    def parsed_report
      JSON.parse(request.raw_post)
    end
  end
end
