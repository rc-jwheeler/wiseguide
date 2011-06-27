module SurveyorHelper
  def display_response(r_set,question)
    sets = r_set.responses.select do |r| 
      r.question == question && r.question.display_order == question.display_order
    end
    
    if sets.size == 0
      "-"
    else
      #sets.sort! { |a,b| a.answer.display_order <=> b.answer.display_order }
      sets.sort! { |a,b| sort_value(a) <=> sort_value(b) }
      sets.map { |s| show_answer(s) }.join( question.pick == "any" ? "; " : "<br/>" )
    end
  end
  
  def show_answer(set) 
    this_answer = (set.string_value || set.text_value || set.integer_value || set.float_value).to_s
    if this_answer.blank?
      set.answer.text
    elsif set.answer.hide_label
      this_answer
    else
      "#{set.answer.text}: #{this_answer}"
    end
  end

  def sort_value(set)
    if set.response_group.present?
      set.response_group.to_i * 100 + set.answer.display_order
    else
      set.answer.display_order
    end
  end

  # Layout: stylsheets and javascripts
  def surveyor_includes
    ''
  end
  def surveyor_stylsheets
    ''
  end
  def surveyor_javascripts
    ''
  end
  # Helper for displaying warning/notice/error flash messages
  def flash_messages(types)
    types.map{|type| content_tag(:div, "#{flash[type]}".html_safe, :class => type.to_s)}.join.html_safe
  end
  # Section: dependencies, menu, previous and next
  def dependency_explanation_helper(question,response_set)
    # Attempts to explain why this dependent question needs to be answered by referenced the dependent question and users response
    trigger_responses = []
    dependent_questions = Question.find_all_by_id(question.dependency.dependency_conditions.map(&:question_id)).uniq
    response_set.responses.find_all_by_question_id(dependent_questions.map(&:id)).uniq.each do |resp|
      trigger_responses << resp.to_s
    end
    "&nbsp;&nbsp;You answered &quot;#{trigger_responses.join("&quot; and &quot;")}&quot; to the question &quot;#{dependent_questions.map(&:text).join("&quot;,&quot;")}&quot;"
  end
  def menu_button_for(section)
    submit_tag(section.title, :name => "section[#{section.id}]")
  end
  def previous_section
    # use copy in memory instead of making extra db calls
    submit_tag(t('surveyor.previous_section').html_safe, :name => "section[#{@sections[@sections.index(@section)-1].id}]") unless @sections.first == @section
  end
  def next_section
    # use copy in memory instead of making extra db calls
    @sections.last == @section ? submit_tag(t('surveyor.click_here_to_finish').html_safe, :name => "finish") : submit_tag(t('surveyor.next_section').html_safe, :name => "section[#{@sections[@sections.index(@section)+1].id}]")
  end
  
  # Questions
  def q_text(obj)
    @n ||= 0
    return image_tag(obj.text) if obj.is_a?(Question) and obj.display_type == "image"
    return obj.text if obj.is_a?(Question) and (obj.dependent? or obj.display_type == "label" or obj.part_of_group?)
    "#{@n += 1}) #{obj.text}"
  end
  # def split_text(text = "") # Split text into with "|" delimiter - parts to go before/after input element
  #   {:prefix => text.split("|")[0].blank? ? "&nbsp;" : text.split("|")[0], :postfix => text.split("|")[1] || "&nbsp;"}
  # end
  # def question_help_helper(question)
  #   question.help_text.blank? ? "" : %Q(<span class="question-help">#{question.help_text}</span>)
  # end
  
  # Answers
  def rc_to_attr(type_sym)
    case type_sym.to_s
    when /^date|time$/ then :datetime_value
    when /(string|text|integer|float|datetime)/ then "#{type_sym.to_s}_value".to_sym
    else :answer_id
    end
  end
  def rc_to_as(type_sym)
    case type_sym.to_s
    when /(integer|float)/ then :string
    else type_sym
    end
  end
  def generate_pick_none_input_html(response_class, default_value, css_class)
    html = {}
    html[:class] = css_class unless css_class.blank?
    html[:value] = default_value if response_class.blank?
    html
  end
  
  # Responses
  def response_for(response_set, question, answer = nil, response_group = nil)
    return nil unless response_set && question && question.id
    result = response_set.responses.detect{|r| (r.question_id == question.id) && (answer.blank? ? true : r.answer_id == answer.id) && (r.response_group.blank? ? true : r.response_group.to_i == response_group.to_i)}
    result.blank? ? response_set.responses.build(:question_id => question.id, :response_group => response_group) : result
  end
  def response_idx(increment = true)
    @rc ||= 0
    (increment ? @rc += 1 : @rc).to_s
  end
end
