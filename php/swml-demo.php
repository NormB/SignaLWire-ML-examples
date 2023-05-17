#!/usr/bin/env php
<?php

require_once 'SignalWireML.php';

use SignalWire\ML;

$swml = new SignalWireML(['version' => '1.0.2', 'voice' => 'en-GB-Neural2-F']);

$swml->set_aiprompt([
    'temperature' => '0.9',
    'top_p' => '1.0',
    'text' => 'Your name is Olivia, You are able to lookup weather and time for various locations.  Caller can ask anything.'
]);

$swml->set_aipost_prompt([
    'text' => 'Summarize the conversation'
]);

$swml->add_aihints('jokes', 'weather', 'time');

$swml->set_aipost_prompt_url([
    'post_prompt_url' => getenv('post_prompt_url')
]);

$swml->add_aiswaig_defaults(['web_hook_url' => getenv('web_hook_url')]);

$swml->add_aiswaig_function([
    'function' => 'get_weather',
    'purpose' => 'To determine what the current weather is in a provided location.',
    'argument' => 'The location or name of the city to get the weather from.'
]);

$swml->add_aiswaig_function([
    'function' => 'get_world_time',
    'purpose' => 'To determine what the current time is in a provided location.',
    'argument' => 'The location or name of the city to get the time from.'
]);

$swml->add_aiapplication('main');

header('Content-Type: application/json');
echo $swml->render_json();


