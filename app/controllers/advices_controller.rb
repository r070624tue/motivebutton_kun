require 'net/http'
require 'json'
require 'uri'

class AdvicesController < ApplicationController
  def create
    @date  = Date.parse(params[:date])
    @tasks = current_user.tasks.where(date_on: @date).order(:created_at)
    @mood  = current_user.moods.where(date_on: @date).order(created_at: :desc).first

    if @mood.nil? || @tasks.empty?
      render json: { advice: "気分やタスクが登録されていないため、アドバイスを生成できません。" }
      return
    end

    mood_name_text = @mood.mood_name
    mood_score_text = "スコアが#{@mood.score}点"
    task_list = @tasks.map(&:content).join('、')
    prompt = "今日の気分は「#{mood_name_text}」（#{mood_score_text}）で、やるべきタスクは「#{task_list}」です。この状況を踏まえて、ポジティブで具体的なアドバイスを100文字程度でお願いします。"

    begin
      advice_text = openai_api_call(prompt)
      render json: { advice: advice_text.strip }
    rescue => e
      Rails.logger.error "Advice Generation Error: #{e.message}"
      render json: { advice: "サーバー側でエラーが発生しました。" }, status: :internal_server_error
    end
  end

  private

  def openai_api_call(prompt)
    uri = URI.parse('https://api.openai.com/v1/chat/completions')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{ENV['OPENAI_API_KEY']}"
    request.body = {
      model: 'gpt-5-mini',
      messages: [
        { role: 'user', content: prompt }
      ]
    }.to_json

    response = http.request(request)
    response_body = JSON.parse(response.body)

    if response.code.to_i == 200
      response_body.dig('choices', 0, 'message', 'content')
    else
      Rails.logger.error "OpenAI API Error: #{response_body}"
      raise "OpenAI API Error: #{response_body['error']&.dig('message') || response_body}"
    end
  end
end