module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t ".title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def create_answer_index index
    (index + 65).chr + ". "
  end

  def convert_datetime date
    date.to_formatted_s(:long)
  end

  def index_for counter, page, per_page
    (page - 1) * per_page + counter + 1
  end
end
