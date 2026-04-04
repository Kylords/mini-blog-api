# frozen_string_literal: true

module Prompts
  module Schemas
    class AiSummary
      GENERATE_AI_SUMMARY_RESPONSE = {
        type: 'object',
        properties: {
          summary: {
            type: 'string',
            description: 'A concise summary of the post containing three sentences or fewer'
          }
        },
        required: ['summary'],
        additionalProperties: false
      }.freeze
    end
  end
end
