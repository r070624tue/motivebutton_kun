class AdvicesController < ApplicationController
  def create
    @date  = Date.parse(params[:date])
    @tasks = current_user.tasks.where(date_on: @date).order(:created_at)
    @mood  = current_user.moods.where(date_on: @date).order(created_at: :desc).first

    if @mood.nil? || @tasks.empty?
      render json: { advice: "気分やタスクが登録されていないため、アドバイスを生成できません。" }
      return
    end

    mood_text = "スコアが#{@mood.score}点"
    task_list = @tasks.map(&:content).join('、')
    prompt = "今日の気分のスコアは「#{mood_text}」で、やるべきタスクは「#{task_list}」です。この状況を踏まえて、ポジティブで具体的なアドバイスを100文字程度でお願いします。"

    begin
      response = openai_api_call(prompt)

      if response.status.success?
        advice_text = JSON.parse(response.body.to_s).dig("choices", 0, "message", "content")
        render json: { advice: advice_text.strip }
      else
        Rails.logger.error "OpenAI API Error: #{response.body.to_s}"
        render json: { advice: "AIからのアドバイス取得に失敗しました。" }, status: :internal_server_error
      end
    rescue => e
      Rails.logger.error "Advice Generation Error: #{e.message}"
      render json: { advice: "サーバー側でエラーが発生しました。" }, status: :internal_server_error
    end
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