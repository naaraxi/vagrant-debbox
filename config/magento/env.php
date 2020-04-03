<?php
return [
    'backend' => [
        'frontName' => 'admin'
    ],
    'crypt' => [
        'key' => '[__CRYPT_KEY__]'
    ],
    'db' => [
        'table_prefix' => '',
        'connection' => [
            'default' => [
                'host' => 'localhost',
                'dbname' => '[__DB_NAME__]',
                'username' => 'root',
                'password' => 'vagrant',
                'model' => 'mysql4',
                'engine' => 'innodb',
                'initStatements' => 'SET NAMES utf8;',
                'active' => '1'
            ]
        ]
    ],
    'resource' => [
        'default_setup' => [
            'connection' => 'default'
        ]
    ],
    'x-frame-options' => 'SAMEORIGIN',
    'MAGE_MODE' => 'developer',
    'http_cache_hosts' => [
        [
            'host' => 'localhost',
            'port' => '80'
        ]
    ],
    'session' => [
        'save' => 'db'
    ],
    'cache_types' => [
        'config' => 0,
        'layout' => 0,
        'block_html' => 0,
        'collections' => 0,
        'reflection' => 0,
        'db_ddl' => 0,
        'eav' => 0,
        'customer_notification' => 0,
        'config_integration' => 0,
        'config_integration_api' => 0,
        'full_page' => 0,
        'translate' => 0,
        'config_webservice' => 0,
        'compiled_config' => 0,
        'vertex' => 0
    ],
    'install' => [
        'date' => 'Wed, 11 Mar 2020 10:03:46 +0000'
    ]
];
