class EventsController < ApplicationController
  PER_PAGE = 12

  def index
    @feedbacks = Feedback.includes(:event).all
    @feedbacks = @feedbacks.joins(:event).where(feedbacks: { event: params[:event_id] }) if params[:event_id].present?
    if params[:rating].present?
      @feedbacks = @feedbacks.where(feedbacks: { rating: params[:rating] })
    end

    @feedbacks = @feedbacks.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end
end
