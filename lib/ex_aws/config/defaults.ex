defmodule ExAws.Config.Defaults do
  @moduledoc """
  Defaults for each service
  """

  @common %{
    access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, {:awscli, "default", 30}, :instance_role],
    secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, {:awscli, "default", 30}, :instance_role],
    http_client: ExAws.Request.Hackney,
    json_codec: Poison,
    retries: [
      max_attempts: 10,
      base_backoff_in_ms: 10,
      max_backoff_in_ms: 10_000
    ],
  }

  @defaults %{
    kinesis: %{
      scheme: "https://",
      host: {"$region", "kinesis.$region.amazonaws.com"},
      region: "us-east-1",
      port: 80
    },
    firehose: %{
      scheme: "https://",
      host: {"$region", "firehose.$region.amazonaws.com"},
      region: "us-east-1",
      port: 80
    },
    dynamodb: %{
      scheme: "https://",
      host: {"$region", "dynamodb.$region.amazonaws.com"},
      region: "us-east-1",
      port: 80
    },
    lambda: %{
      host: {"$region", "lambda.$region.amazonaws.com"},
      scheme: "https://",
      region: "us-east-1",
      port: 80
    },
    s3: %{
      scheme: "https://",
      host: %{
        "us-east-1" => "s3.amazonaws.com",
        "us-west-1" => "s3-us-west-1.amazonaws.com",
        "us-west-2" => "s3-us-west-2.amazonaws.com",
        "eu-west-1" => "s3-eu-west-1.amazonaws.com",
        "eu-central-1" => "s3-eu-central-1.amazonaws.com",
        "ap-southeast-1" => "s3-ap-southeast-1.amazonaws.com",
        "ap-southeast-2" => "s3-ap-southeast-2.amazonaws.com",
        "ap-northeast-1" => "s3-ap-northeast-1.amazonaws.com",
        "sa-east-1" => "s3-sa-east-1.amazonaws.com",
      },
      region: "us-east-1"
    },
    sqs: %{
      scheme: "https://",
      host: {"$region", "sqs.$region.amazonaws.com"},
      region: "us-east-1",
      port: 80
    },
    sns: %{
      host: {"$region", "sns.$region.amazonaws.com"},
      scheme: "https://",
      region: "us-east-1",
      port: 80
    },
    ec2: %{
      scheme: "https://",
      host: {"$region", "ec2.$region.amazonaws.com"},
      region: "us-east-1",
      port: 80
    },
    rds: %{
      scheme: "https://",
      host: {"$region", "rds.$region.amazonaws.com"},
      region: "us-east-1",
      port: 80
    },
    kms: %{
      scheme: "https://",
      host: {"$region", "kms.$region.amazonaws.com"},
      region: "us-east-1",
      port: 80
    },
    monitoring: %{
      scheme: "https://",
      host: {"$region", "monitoring.$region.amazonaws.com"},
      region: "us-east-1",
      port: 80
    },
  }

  @doc """
  Retrieve the default configuration for a service.
  """
  for {service, config} <- @defaults do
    config = Map.merge(config, @common)
    def get(unquote(service)), do: unquote(Macro.escape(config))
  end
end
