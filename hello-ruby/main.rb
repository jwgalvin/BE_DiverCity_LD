# Import the LaunchDarkly client.
require 'ldclient-rb'
ld_sdk_key = ENV[sdk_key]
# Create a new LDClient with your environment-specific SDK key.
client = LaunchDarkly::LDClient.new("#{ld_sdk_key}")

# Create a helper function for rendering messages.
def show_message(s)
  puts "*** #{s}"
  puts
end

if client.initialized?
  show_message "SDK successfully initialized!"
else
  show_message "SDK failed to initialize"
  exit 1
end

# Set up the user properties. This user should appear on your LaunchDarkly users dashboard
# soon after you run the demo.
user = {
  key: "example-user-key",
  name: "Bob Loblaw"
}

# Call LaunchDarkly with the feature flag key you want to evaluate.
flag_value = client.variation("email_worker", user, false)

show_message "Feature flag 'email_worker' is #{flag_value} for this user"

# Here we ensure that the SDK shuts down cleanly and has a chance to deliver analytics
# events to LaunchDarkly before the program exits. If analytics events are not delivered,
# the user properties and flag usage statistics will not appear on your dashboard. In a
# normal long-running application, the SDK would continue running and events would be
# delivered automatically in the background.
client.close()
