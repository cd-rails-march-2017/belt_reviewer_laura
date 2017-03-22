class EventsController < ApplicationController
  def index
    if session[:user_id] == nil
      redirect_to '/users/new'
    else
      @user_id = session[:user_id]
      @user = User.find(session[:user_id])
      @events = Event.where('state=?', @user.state)
      @otherevents = Event.where.not('state=?', @user.state)
    end
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "You have successfully added an event!"
      redirect_to root_path
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to root_path
    end
  end

  def show
    @event = Event.find(params[:id])
    @comments = Comment.where("event_id=?", params[:id])
    @count = Attendee.where("event_id=?", params[:id]).count
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    success = event.update(event_params)
    if success
      redirect_to '/events'
    else
      flash[:errors] = event.errors.full_messages
      redirect_to "/events/#{@params[:id]}/edit"
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to '/events'
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :city, :state, :host_id)
  end

end
