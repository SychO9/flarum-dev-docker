<?php return array (
  'debug' => env('APP_DEBUG', false),
  'database' =>
  array (
    'driver' => env('DB_DRIVER'),
    'host' => env('DB_HOST'),
    'port' => env('DB_PORT'),
    'database' => env('DB_DATABASE'),
    'username' => env('DB_USERNAME'),
    'password' => env('DB_PASSWORD'),
    'charset' => env('DB_CHARSET', 'utf8mb4'),
    'collation' => env('DB_COLLATION', 'utf8mb4_unicode_ci'),
    'prefix' => env('DB_PREFIX', ''),
    'strict' => env('DB_STRICT_MODE', false),
    'engine' => env('DB_ENGINE', null),
    'prefix_indexes' => env('DB_PREFIX_INDEXES', true),
  ),
  'url' => env('APP_URL', 'http://localhost:8000'),
  'paths' =>
  array (
    'api' => env('APP_PATH_API', 'api'),
    'admin' => env('APP_PATH_ADMIN', 'admin'),
  ),
  'headers' =>
  array (
    'poweredByHeader' => env('APP_POWERED_BY_HEADER', true),
    'referrerPolicy' => env('APP_REFERRER_POLICY', 'same-origin'),
  ),
);
