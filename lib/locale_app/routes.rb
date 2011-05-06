module LocaleApp
  module Routes

    def project_url(options = {})
      options[:format] ||= 'json'
      URI::HTTP.build(base_options.merge(:path => project_path(options[:format]))).to_s
    end

    def translations_url(options={})
      options[:format] ||= 'json'
      url = URI::HTTP.build(base_options.merge(:path => translations_path(options[:format])))
      url.query = options[:query].map { |k,v| "#{k}=#{v}" }.join('&') if options[:query]
      url.to_s
    end

  private

    def base_options
      options = {:host => LocaleApp.configuration.host, :port => LocaleApp.configuration.port}
      if LocaleApp.configuration.http_auth_username
        options[:userinfo] = "#{LocaleApp.configuration.http_auth_username}:#{LocaleApp.configuration.http_auth_password}"
      end
      options
    end

    def project_path(format = nil)
      path = "/projects/#{LocaleApp.configuration.api_key}"
      path << ".#{format}" if format
      path
    end

    def translations_path(format = nil)
      path = project_path << '/translations'
      path << ".#{format}" if format
      path
    end
  end
end