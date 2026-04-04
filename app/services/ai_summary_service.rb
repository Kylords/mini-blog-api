# frozen_string_literal: true

require 'faraday'
require 'json'

class AiSummaryService
  PROMPT_PATH = Rails.root.join('lib/prompts/ai_summary_service.md')

  def self.generate_summary(content:, title:)
    prompt_template = File.read(PROMPT_PATH)

    full_prompt = <<~PROMPT
      #{prompt_template}

      POST TITLE: #{title}
      POST CONTENT:
      #{content}
    PROMPT

    response = connection.post do |req|
      req.body = {
        model: 'gpt-4o-mini',
        messages: [
          { role: 'user', content: full_prompt }
        ],
        response_format: {
          type: 'json_schema',
          json_schema: {
            name: 'ai_summary_response',
            schema: ::Prompts::Schemas::AiSummary::GENERATE_AI_SUMMARY_RESPONSE
          }
        }
      }.to_json
    end

    parsed = JSON.parse(response.body)

    content = parsed.dig('choices', 0, 'message', 'content')
    json = JSON.parse(content)

    json['summary']
  end

  def self.connection
    @connection ||= Faraday.new(url: ENV['OPENAI_API_URL']) do |f|
      f.headers['Authorization'] = "Bearer #{ENV['OPENAI_API_KEY']}"
      f.headers['Content-Type'] = 'application/json'
    end
  end
end
