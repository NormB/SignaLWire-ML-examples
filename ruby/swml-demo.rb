require_relative 'signalwireml'
swml = SignalWireML.new(version: '1.0.1', voice: 'en-US')

swml.add_ailanguage({ name: 'English', code: 'en-US', voice: 'en-US-Neural2-F' })
swml.add_aiparams({ sms_from_number: '+19184588888' })
swml.add_aiparams({ languages_enabled: 'true' })
swml.add_aiparams({ language_mode: 'normal' })
swml.set_aiprompt({ temperature: '0.9', top_p: '0.9', text: 'You name is Franklin and you are an expert at Star Wars. Introduce yourself and see if I have any questions.' })
swml.set_aipost_prompt({ text: 'Please summarize the conversation.' })
swml.add_aihints('foo', 'bar', 'baz')

swml.add_aiswaig_defaults({ web_hook_url: ENV['webHookURL'] })

swml.add_aiswaig_function({
                          'function' => 'get_weather',
                          purpose: 'To determine what the current weather is in a provided location.',
                          argument: 'The location or name of the city to get the weather from.' })

swml.add_aiswaig_function({
                          'function' => 'get_world_time',
                          purpose: 'To determine what the current time is in a provided location.',
                          argument: 'The location or name of the city to get the time from.' })

swml.add_aiapplication('main')

swml.add_application('test', 'play',
                    { urls:
                        ['https://github.com/freeswitch/freeswitch-sounds/raw/master/fr/ca/june/voicemail/48000/vm-goodbye.wav'] })
swml.add_application('test', 'hangup', 'NORMAL_CLEARING')
swml.add_application('blah', 'play',
                    { urls:
                        [ 'https://github.com/freeswitch/freeswitch-sounds/raw/master/en/us/callie/ivr/48000/ivr-welcome_to_freeswitch.wav'] })
swml.add_application('blah', 'transfer', 'test')

json_output = swml.render_json
puts "JSON output:"
puts json_output

yaml_output = swml.render_yaml
puts "\nYAML output:"
puts yaml_output
