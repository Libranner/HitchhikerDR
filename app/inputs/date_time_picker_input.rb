class DateTimePickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'datetimepicker input-append') do
      template.concat @builder.text_field(attribute_name, input_html_options) + span_div
    end
  end

  def input_html_options
    {'data-format' => "MM/dd/yyyy HH:mm:ss PP", placeholder: 'dd/mm/yyyy 00:00:00 AM'}
  end

  def span_div
    template.content_tag(:span, class: 'add-on') do
      template.concat icon_div.html_safe
    end
  end

  def icon_div
    "<i class='icon-calendar' data-time-icon='icon-calendar' data-date-icon='icon-calendar'></i>"
  end
end