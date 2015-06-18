<?php

return [
    'api_key' => getenv('BUGSNAG_KEY'),
    'notify_release_stages' => ['production', 'development', 'staging'],
];
