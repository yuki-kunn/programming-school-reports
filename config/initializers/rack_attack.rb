# ブルートフォース攻撃・レート制限の設定

class Rack::Attack
  # ===== ログイン試行制限 =====

  # 同一IPから5分間に10回以上ログイン試行したらブロック
  throttle('login/ip', limit: 10, period: 5.minutes) do |req|
    req.ip if req.path == '/session' && req.post?
  end

  # 同一メールアドレスで5分間に10回以上ログイン試行したらブロック
  throttle('login/email', limit: 10, period: 5.minutes) do |req|
    if req.path == '/session' && req.post?
      req.params.dig('session', 'email')&.downcase&.strip
    end
  end

  # ===== ブロック時のレスポンス =====
  self.throttled_responder = lambda do |request|
    retry_after = (request.env['rack.attack.match_data'] || {})[:period]
    [
      429,
      {
        'Content-Type' => 'text/html; charset=utf-8',
        'Retry-After'  => retry_after.to_s
      },
      [<<~HTML]
        <!DOCTYPE html>
        <html lang="ja">
          <head><meta charset="UTF-8"><title>リクエスト制限</title></head>
          <body style="font-family:sans-serif;text-align:center;padding:4rem;">
            <h1 style="color:#ef4444;">リクエストが多すぎます</h1>
            <p>しばらく時間をおいてから再度お試しください。</p>
          </body>
        </html>
      HTML
    ]
  end

  # ===== 開発環境では制限を無効化 =====
  if Rails.env.development? || Rails.env.test?
    safelist('allow-all-in-dev') { |req| true }
  end
end
