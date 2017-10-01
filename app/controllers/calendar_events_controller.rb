class CalendarEventsController < ApplicationController

	before_action :authenticate_user!	
  before_action :set_calendar_event, only: [:edit, :update, :destroy, :show]
  before_action :set_period_types, only: [:new, :create, :edit, :update]

	def new
		@event = CalendarEvent.new
	end

	def create
    @event = CalendarEvent.new(calendar_event_params)

    if @event.save
      redirect_to edit_calendar_event_path(@event.id), notice: 'Событие успешно добавлено'
    else
      render 'new'
    end
	end

	def edit
	end

	def update
    if @event.update(calendar_event_params)
      redirect_to edit_calendar_event_path(@event.id), notice: 'Событие успешно обнавлено'
    else
      render :edit
    end		
	end

  def show
  end

	def index
    @c_year = params[:year] ? params[:year].to_i : Date.today.year.to_i
    @c_month = params[:month] ? params[:month].to_i : Date.today.month.to_i

    @dates_range = Date.new(@c_year, @c_month)..Date.new(@c_year, @c_month).end_of_month
    @years_arr = get_years_for_calendar(5)
    @months_arr = get_month_for_calendar
    @day_names_arr = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс']

    @start_offset_range = start_offset_range(@c_year, @c_month)
    @end_offset_range = end_offset_range(@c_year, @c_month)

    @events = CalendarEvent.where('date <= ?', @dates_range.last)
    @pair_day_and_events = @dates_range.map { |date| [date, []] }

    @events.each do |event|
      case event.periodicity
        when 'День'
          @pair_day_and_events.each do |pair|
            pair[1].push(event) if event.date <= pair[0]
          end
        when 'Неделя'
          @pair_day_and_events.each do |pair|
            pair[1].push(event) if event.date <= pair[0] && event.date.strftime("%A") == pair[0].strftime("%A")
          end
        when 'Месяц'
          @pair_day_and_events.each do |pair|
            pair[1].push(event) if event.date <= pair[0] && event.date.day == pair[0].day
          end
        when 'Год'
          @pair_day_and_events.each do |pair|
            pair[1].push(event) if event.date <= pair[0] && event.date.month == pair[0].month && event.date.day == pair[0].day
          end
      end
    end

	end

	def list_events
    @events = CalendarEvent.all
	end

  def user_list_events
    @events = CalendarEvent.where(user_id: current_user.id)
  end

  def destroy
    @event.destroy
    redirect_back fallback_location: root_path
  end

  private

  def calendar_event_params
    params.require(:calendar_event).permit(:name, :user_id, :date, :periodicity)
  end

  def set_calendar_event
    @event = CalendarEvent.find(params[:id])
  end

  def set_period_types
		@period_types = CalendarEvent::PERIOD_TYPES
  end

  def get_years_for_calendar(year_indent)
    return if CalendarEvent.all.size == 0
    min_year = CalendarEvent.minimum(:date).year
    max_year = CalendarEvent.maximum(:date).year + year_indent
    # max_year = min_year
    # if CalendarEvent.where(periodicity: 'Год').first
    #   max_year = CalendarEvent.where(periodicity: 'Год').maximum(:date).year + year_indent
    # end
    (min_year..max_year).to_a
  end

  def get_month_for_calendar
    ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
    'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']
  end

  def start_offset_range year, month
    last_day_prev_month = (DateTime.new(year, month) - 1.month).end_of_month.strftime('%d').to_i
    first_day_name = DateTime.new(year, month).strftime('%w').to_i
    first_day_name = 7 if first_day_name == 0
    (last_day_prev_month - first_day_name + 2..last_day_prev_month).to_a
  end

  def end_offset_range year, month
    last_day_name = DateTime.new(year, month).end_of_month.strftime('%w').to_i
    if last_day_name == 0
      return []
    end
      return (1..7-last_day_name).to_a
    else
  end

end