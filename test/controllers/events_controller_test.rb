require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
    @feedback = feedbacks(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
    assert_select "h1", "Event Feedback Hub"
    assert_select "form#new_feedback"
    assert_select "#feedbacks"
  end

  test "should handle event filtering" do
    get events_url, params: { event_id: @event.id }
    assert_response :success
    assert_select "#feedbacks" do
      assert_select ".feedback" do
        assert_select "div", @event.name
      end
    end
  end

  test "should handle rating filtering" do
    get events_url, params: { rating: @feedback.rating }
    assert_response :success
    assert_select "#feedbacks" do
      assert_select ".feedback" do
        assert_select "div.text-yellow-500", /★{#{@feedback.rating}}/
      end
    end
  end

  test "should handle combined filtering" do
    get events_url, params: { event_id: @event.id, rating: @feedback.rating }
    assert_response :success
    assert_select "#feedbacks" do
      assert_select ".feedback" do
        assert_select "div", @event.name
        assert_select "div.text-yellow-500", /★{#{@feedback.rating}}/
      end
    end
  end

  test "should paginate feedbacks" do
    # Create enough feedbacks to trigger pagination
    15.times do |i|
      Feedback.create!(
        event: @event,
        user_name: "User#{i}",
        rating: rand(1..5),
        comment: "Test comment #{i}"
      )
    end

    get events_url
    assert_response :success
    assert_select ".pagination"
    assert_select "#feedbacks .feedback", EventsController::PER_PAGE
  end
end
