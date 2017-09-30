class CalendarEvent < ApplicationRecord
	validates_presence_of :name, :date

	PERIOD_TYPES = [
		'День',
		'Неделя',
		'Месяц',
		'Год'
	]

end
