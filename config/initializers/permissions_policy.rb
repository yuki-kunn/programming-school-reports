# Be sure to restart your server when you modify this file.

# Define an application-wide permissions policy.
Rails.application.config.permissions_policy do |f|
  f.camera      :none
  f.gyroscope   :none
  f.microphone  :none
  f.usb         :none
  f.fullscreen  :self
  f.payment     :none
end
