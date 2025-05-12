class FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend(:feedbacks, partial: "feedbacks/feedback", locals: { feedback: @feedback }) }
        format.html { redirect_to events_path, notice: "Feedback was successfully submitted." }
      end
    else
      redirect_to events_path, alert: @feedback.errors.full_messages.join(", ")
    end
  end

  private

  def feedback_params
    params.expect(feedback: %i[event_id user_name rating comment])
  end
end
