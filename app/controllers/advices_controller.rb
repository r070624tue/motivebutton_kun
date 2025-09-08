class AdvicesController < ApplicationController
  def create
    @date  = Date.parse(params[:date])
    @tasks = current_user.tasks.where(date_on: @date).order(:created_at)
    @mood  = current_user.moods.where(date_on: @date).order(created_at: :desc).first

    prompt = "今日の気分は「#{@mood}」で、やるべきタスクは「#{@tasks}」です。この状況を踏まえて、ポジティブで具体的なアドバイスを100文字程度でお願いします。"
    openai_api_call(prompt)
  end

  private

  def openai_api_call(prompt)
    HTTP.post(
      'https://api.openai.com/v1/chat/completions',
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}"
      },
      json: {
        model: "gpt-5-mini",
        messages: [{ role: "user", content: prompt }]
      }
    )
  end
end
