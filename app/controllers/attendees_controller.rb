class AttendeesController < ApplicationController

def create
  @rsvp = Attendee.new(user_id:session[:user_id], event_id:params[:id])
  if @rsvp.save
    redirect_to '/events'
  else
    flash[:errors] = ['Unable to join event']
    redirect_to '/events'
  end
end

def destroy
  rsvp = Attendee.where("user_id=? AND event_id=?", session[:user_id], params[:id])
  rsvp[0].destroy
  redirect_to '/events'
end

end
