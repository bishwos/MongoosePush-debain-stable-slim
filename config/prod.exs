import Config

config :goth, endpoint: {:system, :string, "FCM_AUTH_ENDPOINT", "https://www.googleapis.com"}

config :mongoose_push, MongoosePushWeb.Endpoint,
  https: [
    ip: {
      :system,
      # Custom type parser (Phoenix needs erlang-inet-style IP address)
      {MongoosePush.Config.Utils, :parse_bind_addr, []},
      "PUSH_HTTPS_BIND_ADDR",
      {127, 0, 0, 1}
    },
    port: {:system, :integer, "PUSH_HTTPS_PORT", 8443},
    keyfile: {:system, :string, "PUSH_HTTPS_KEYFILE", "priv/ssl/fake_key.pem"},
    certfile: {:system, :string, "PUSH_HTTPS_CERTFILE", "priv/ssl/fake_cert.pem"},
    cacertfile: {:system, :string, "PUSH_HTTPS_CERTFILE", "priv/ssl/fake_cert.pem"},
    protocol_options: [
      # https://ninenines.eu/docs/en/cowboy/2.5/manual/cowboy_http/
    ],
    transport_options: [
      # https://ninenines.eu/docs/en/ranch/1.6/manual/ranch_tcp/
      # https://ninenines.eu/docs/en/ranch/1.6/manual/ranch_ssl/
      num_acceptors: {:system, :integer, "PUSH_HTTPS_ACCEPTORS", 100}
    ],
    otp_app: :mongoose_push
  ],
  debug_errors: false,
  code_reloader: false,
  check_origin: true,
  server: true

config :mongoose_push, :logging,
  level: {:system, :atom, "PUSH_LOGLEVEL", :info},
  format: {:system, :atom, "PUSH_LOGFORMAT", :json}

config :mongoose_push, fcm_enabled: {:system, :boolean, "PUSH_FCM_ENABLED", true}

config :mongoose_push, apns_enabled: {:system, :boolean, "PUSH_APNS_ENABLED", true}

config :mongoose_push,
  tls_server_cert_validation: {:system, :boolean, "TLS_SERVER_CERT_VALIDATION", true}

config :mongoose_push,
  fcm: [
    default: [
      endpoint: {:system, :string, "PUSH_FCM_ENDPOINT", nil},
      port: {:system, :integer, "PUSH_FCM_PORT", nil},
      appfile: {:system, :string, "PUSH_FCM_APP_FILE", "priv/fcm/token.json"},
      pool_size: {:system, :integer, "PUSH_FCM_POOL_SIZE", 5},
      mode: :prod
    ]
  ]

config :mongoose_push,
  apns: [
    dev: [
      auth: %{
        type: {:system, :atom, "PUSH_APNS_AUTH_TYPE", :token},
        cert: {:system, :string, "PUSH_APNS_DEV_CERT", "priv/apns/dev_cert.pem"},
        key: {:system, :string, "PUSH_APNS_DEV_KEY", "priv/apns/dev_key.pem"},
        key_id: {:system, :string, "PUSH_APNS_DEV_KEY_ID", nil},
        team_id: {:system, :string, "PUSH_APNS_DEV_TEAM_ID", nil},
        p8_file_path: {:system, :string, "PUSH_APNS_DEV_P8_TOKEN", "priv/apns/token.p8"}
      },
      endpoint: {:system, :string, "PUSH_APNS_DEV_ENDPOINT", nil},
      mode: :dev,
      use_2197: {:system, :boolean, "PUSH_APNS_DEV_USE_2197", false},
      pool_size: {:system, :integer, "PUSH_APNS_DEV_POOL_SIZE", 5},
      default_topic: {:system, :string, "PUSH_APNS_DEV_DEFAULT_TOPIC", nil}
    ],
    prod: [
      auth: %{
        type: {:system, :atom, "PUSH_APNS_AUTH_TYPE", :token},
        cert: {:system, :string, "PUSH_APNS_PROD_CERT", "priv/apns/prod_cert.pem"},
        key: {:system, :string, "PUSH_APNS_PROD_KEY", "priv/apns/prod_key.pem"},
        key_id: {:system, :string, "PUSH_APNS_PROD_KEY_ID", nil},
        team_id: {:system, :string, "PUSH_APNS_PROD_TEAM_ID", nil},
        p8_file_path: {:system, :string, "PUSH_APNS_PROD_P8_TOKEN", "priv/apns/token.p8"}
      },
      endpoint: {:system, :string, "PUSH_APNS_PROD_ENDPOINT", nil},
      mode: :prod,
      use_2197: {:system, :boolean, "PUSH_APNS_PROD_USE_2197", false},
      pool_size: {:system, :integer, "PUSH_APNS_PROD_POOL_SIZE", 5},
      default_topic: {:system, :string, "PUSH_APNS_PROD_DEFAULT_TOPIC", nil}
    ]
  ]

config :mongoose_push,
  openapi: [
    expose_spec: {:system, :boolean, "PUSH_OPENAPI_EXPOSE_SPEC", false},
    expose_ui: {:system, :boolean, "PUSH_OPENAPI_EXPOSE_UI", false}
  ]
