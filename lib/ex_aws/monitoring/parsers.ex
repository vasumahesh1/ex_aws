if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.Monitoring.Parsers do
    import SweetXml, only: [sigil_x: 2]

    def parse({:ok, %{body: xml}=resp}, :put_metric_data) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//PutMetricDataResponse", request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    defp request_id_xpath do
      ~x"./ResponseMetadata/RequestId/text()"s
    end
  end
else
  defmodule ExAws.Monitoring.Parsers do
    def parse(val, _), do: val
  end
end
