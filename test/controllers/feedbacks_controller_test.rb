require "test_helper"

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should create feedback with valid attributes via html" do
    assert_difference("Feedback.count") do
      post feedbacks_path, params: {
        feedback: {
          event_id: @event.id,
          user_name: "John Doe",
          rating: 5,
          comment: "Great event!"
        }
      }
    end

    assert_redirected_to events_path
    assert_equal "Feedback was successfully submitted.", flash[:notice]
  end

  test "should create feedback with valid attributes via turbo stream" do
    assert_difference("Feedback.count") do
      post feedbacks_path, params: {
        feedback: {
          event_id: @event.id,
          user_name: "John Doe",
          rating: 5,
          comment: "Great event!"
        }
      }, as: :turbo_stream
    end

    assert_response :success
    assert_match(/turbo-stream/, @response.media_type)
  end

  test "should not create feedback with invalid attributes" do
    assert_no_difference("Feedback.count") do
      post feedbacks_path, params: {
        feedback: {
          event_id: @event.id,
          user_name: "", # invalid: blank user_name
          rating: 5,
          comment: "Great event!"
        }
      }
    end

    assert_redirected_to events_path
    assert_not_empty flash[:alert]
  end
end
