at_exit do
  if ENV['REPORTBUILDER']
    require 'report_builder'
    time = Time.now.getutc
    time.localtime
    ReportBuilder.configure do |config|
      config.encoding = 'utf-8'
      config.input_path = 'reports/'
      config.report_path = "reports/report_builder_report_#{Time.now.strftime('%H-%M-%S')}"
      config.report_types = [:html]
      config.report_title = 'Tests Report'
      config.color = 'blue'
      config.additional_css = 'features/support/css_report_builder.css'
      config.additional_info = {
        'Project' => 'Deanta Global - Automation Reports',
        'Env' => ENVIRONMENT,
        'Time Executed' => "#{time.strftime('%d/%m/%Y')} - #{time.strftime('%k:%M')}"
      }
    end
    ReportBuilder.build_report
  end
end
