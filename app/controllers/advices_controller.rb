require 'openai'

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
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: prompt }]
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end