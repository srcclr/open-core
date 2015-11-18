ApplicationController.class_eval do
  ensure_security_headers

  def rescue_discourse_actions(type, status_code, include_ember=false)
    if (request.format && request.format.json?) || (request.xhr?)
      # HACK: do not use render_json_error for topics#show
      if request.params[:controller] == 'topics' && request.params[:action] == 'show'
        return render status: status_code, layout: false, text: (status_code == 404) ? build_not_found_page(status_code) : I18n.t(type)
      end

      render_json_error I18n.t(type), type: type, status: status_code
    else
      layout = include_ember ? 'application' : 'no_ember'
      layout = 'no_ember_with_header' if status_code == 404

      render text: build_not_found_page(status_code, layout)
    end
  end
end
