# frozen_string_literal: true

class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    @subscription_ids = []

    token = params[:token]
    payload = JsonWebToken.decode(token)

    if payload
      @current_user = User.find(payload[:user_id])
    else
      reject
    end
  end

  def execute(data)
    query = data['query']
    variables = ensure_hash(data['variables'])
    operation_name = data['operationName']

    result = MiniBlogApiSchema.execute(
      query,
      context: { current_user: @current_user, channel: self },
      variables: variables,
      operation_name: operation_name
    )

    # Track subscription
    if result.context[:subscription_id]
      @subscription_ids << result.context[:subscription_id]
    end

    # Special response for subscriptions
    if result.subscription?
      transmit(result: { data: nil }, more: true)
    else
      transmit(result: result.to_h)
    end
  end

  def unsubscribed
    @subscription_ids.each do |sid|
      MiniBlogApiSchema.subscriptions.delete_subscription(sid)
    end
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? JSON.parse(ambiguous_param) : {}
    when Hash
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
