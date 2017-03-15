class OperationsChannel < ApplicationCable::Channel
  def subscribed
    #stream_from "operations"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
