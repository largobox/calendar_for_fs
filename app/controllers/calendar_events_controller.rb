class CalendarEventsController < ApplicationController

	before_action :authenticate_user!	
  before_action :set_calendar_event, only: [:edit, :update, :destroy]
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

	def index
	end

	def user_events
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

end