# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :notebook,
  ecto_repos: [Notebook.Repo]

# Configures the endpoint
config :notebook, Notebook.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "k2pHVYzHa3FGxup6p+/VFmMs2UOS74L+oGvQXgVCOjqp7I4OI5QH/YBg5jLd4E1u",
  render_errors: [view: Notebook.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Notebook.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Notebook",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  serializer: Notebook.GuardianSerializer,
  secret_key: %{
    "alg" => "ES512",
    "crv" => "P-521",
    "d" => "zvcmh7bspNEJPcUnQg3kmUG9tFQqwhSBpZdx7ZMgWxbdm5s0sPScRRNOnDh2ncosH_QI8rLPk38O_-m-DMo7z2o",
    "kty" => "EC",
    "use" => "sig",
    "x" => "AYTpS3yu5zu76qLzoQM4dFnYq5wxnkHy4V579u4_62UXXl1FnZQK6K-eE_emTJ3zVf4duyViZWMTK5Xk0pMeVxNg",
    "y" => "AVRMNIxYe0-YSdZryJG4-VyUQjXRhKyHWsO1Fj7AkLm9RYJG_mlM6CpIlgdqWS6WS3ZfdoQQeCsDm4811ThEj8Yy"
  }
