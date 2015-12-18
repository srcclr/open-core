let Project = Discourse.Model.extend({})

Project.reopenClass({
  createFromJson(json) {
    return this.create({
      name: json.name,
      description: json.description,
      stargazersCount: json.stargazers_count,
      forksCount: json.forks_count,
      isCspReports: json.is_csp_reports,
      isBughunt: json.is_bughunt,
      isSslReminder: json.is_ssl_reminder,
      isPluginInstalled: json.is_plugin_installed
    })
  }
})

export default Project
