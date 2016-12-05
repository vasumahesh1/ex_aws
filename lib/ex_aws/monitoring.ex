defmodule ExAws.Monitoring do
  @moduledoc """
  Operations on AWS Monitoring CloudWatch
  """

  def put_metric_data(namespace, metric_data) do
    params = metric_data
    |> format_metric_member_data(%{}, 1)
    |> Map.put("Namespace", namespace)

    request(:put_metric_data, params)
  end

  defp request(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/doc/2010-08-01/",
      params: params |> Map.put("Action", action_string) |> Map.put("Version", "2010-08-01"),
      service: :monitoring,
      action: action,
      parser: &ExAws.Monitoring.Parsers.parse/2
    }
  end

  defp format_metric_member_data([metric | tail], acc, prefix_count) do
    prefix = "MetricData.member.#{prefix_count}."

    acc = acc
    |> Map.put(prefix <> "MetricName", metric.metric_name)
    |> Map.put(prefix <> "Unit", metric.unit)
    |> Map.put(prefix <> "Value", metric.value)
    |> format_metric_dimensions(metric.dimensions, prefix_count, 1)
  end

  defp format_metric_member_data([], acc, prefix_count) do
    acc
  end

  defp format_metric_dimensions(acc, [dimension | tail], member_count, prefix_count) do
    prefix = "MetricData.member.#{member_count}.Dimensions.member#{prefix_count}."

    acc = acc
    |> Map.put(prefix <> "Name", dimension.name)
    |> Map.put(prefix <> "Value", dimension.value)

    prefix_count = prefix_count + 1

    format_metric_dimensions(acc, tail, member_count, prefix_count)
  end

  defp format_metric_dimensions(acc, [], member_count, prefix_count) do
    acc
  end
end
