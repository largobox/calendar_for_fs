class CalendarEvent < ApplicationRecord
	validates_presence_of :name, :date

	validate :date_above_today?

	PERIOD_TYPES = [
		'День',
		'Неделя',
		'Месяц',
		'Год'
	]

	private

	def date_above_today?
		errors.add(:date, 'не должна быть прошедшей') if date.present? && date < Date.today 
	end

end
