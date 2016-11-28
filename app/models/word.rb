class Word < ApplicationRecord
  belongs_to :category
  has_many :answers, dependent: :destroy, inverse_of: :word
  has_many :results

  validates :content, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}

  scope :all_words, -> search {where QUERY_BY_CONTENT, search: "%#{search}%"}

  QUERY_BY_CONTENT = "content like :search"

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}
  validate :check_answers
  class << self
    def import file
      CSV.foreach(file.path, headers: true, col_sep: "|", header_converters: :symbol) do |row|
        row = row.to_hash
        answers_attributes = []
        row[:answers].split(";").each do |answer|
          answer_hash = Hash.new
          arr_answer = answer.split(",")
          answer_hash[:content] = arr_answer[0]
          answer_hash[:is_correct] = arr_answer[1]
          answers_attributes.push answer_hash
        end
        row[:answers_attributes] = answers_attributes
        row.delete :answers
        Word.create! row
      end
    end

    def export
      attributes = %w{id content category_id}
      CSV.generate do |csv|
        csv << attributes
        all.each do |item|
          csv << attributes.map{ |attr| item.send(attr) }
        end
      end
    end

    def list_word
    Word.order(created_at: :ASC).includes(:category)
    end
  end

  private
  def check_answers
    size_correct = self.answers.select{|answer| answer.is_correct}.size
    if size_correct == 0
      errors.add I18n.t("validate.answer"), I18n.t("validate.zero")
    end
    if size_correct > 1
      errors.add I18n.t("validate.answer"), I18n.t(".required_1_correct")
    end
    if answers.length > answers.group_by { |a| a[:content] }.length
      self.errors.add :answers, I18n.t("validate.duplication")
    end
  end
end
