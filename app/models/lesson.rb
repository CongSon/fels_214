require "common"
class Lesson < ApplicationRecord
  include SharedMethods

  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy, inverse_of: :lesson
  has_many :activities, as: :activityable
  delegate :name, to: :category, prefix: true
  before_create :words_for_lesson

  validate :verify_create_lesson

  accepts_nested_attributes_for :results,
    reject_if: proc {|attributes| attributes[:answer_id].blank?}

  scope :lesson_count, -> date_time do
    where("date(created_at) = '#{date_time}'").count
  end

  scope :lesson_in_week, -> (start_date, end_date) do
    where("date(created_at) > '#{start_date}' AND
      date(created_at) <'#{end_date}'").where(is_complete: true)
  end

  def number_correct_answer
    self.results.correct.count
  end

  class << self
    def mark_ladder
      marks = []
      end_date = Lesson.new.get_current_monday
      start_date = end_date - Settings.eight.day
      lessons = Lesson.lesson_in_week(start_date.strftime(Settings.date_format),
        end_date.strftime(Settings.date_format))
      first = second = third = 0
      lessons.each do |lesson|
        if lesson.number_correct_answer < Settings.first_mark
          first += 1
        elsif lesson.number_correct_answer < Settings.second_mark
          second += 1
        else
          third += 1
        end
      end
      marks << {name: Settings.bad, y: first}
      marks << {name: Settings.good, y: second}
      marks << {name: Settings.excellent, y: third}
      marks
    end
  end

  private
  def words_for_lesson
    self.category.words.order("Random()").limit(Settings.lesson.size)
      .each do |word|
      self.results.build word_id: word.id
    end
  end

  def verify_create_lesson
    if Settings.lesson.size > self.category.words.size
      self.errors.add :category, I18n.t(".not_enough_word")
    end
  end

  def verify_user?
    return current_user.id == @lesson.user_id
  end
end
