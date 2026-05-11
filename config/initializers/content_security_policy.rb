# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.font_src    :self
  policy.img_src     :self, :data
  policy.object_src  :none
  policy.script_src  :self
  policy.style_src   :self, :unsafe_inline  # Tailwind CSS requires unsafe-inline for now
  policy.connect_src :self
  policy.frame_ancestors :none
  policy.base_uri    :self
  policy.form_action :self
end

# Generate a nonce for script tags
Rails.application.config.content_security_policy_nonce_generator =
  ->(request) { SecureRandom.base64(16) }
Rails.application.config.content_security_policy_nonce_directives = %w[script-src]
