require Logger

defmodule EmailToTrello do
  def sync_list(list_items, client) do
    Enum.each(list_items,
      fn(item) ->
        sync_item(item, client)
      end
    )
  end

  defp sync_item(item, client) do
    if item_already?(item, client) do
      send_email(item)
      insert_item(item, client)
      log_action(item)
    end
  end

  def send_email(item) do
    HTTPoison.request(:post,
      "https://api.postmarkapp.com/email",
      "{
        From: '#{System.get_env("FROM_EMAIL")}',
        To: '#{System.get_env("TRELLO_EMAIL")}',
        Subject: '#{item[:title]} #{System.get_env("TRELLO_LABEL")}',
        TextBody: 'http://amazon.es/dp/#{item[:reference]}',
        HtmlBody: 'http://amazon.es/dp/#{item[:reference]}',
        Attachments: [
          {
            Name: 'book.jpg',
            Content: '#{download_image(item[:image])}',
            ContentType: 'image/jpeg'
          }
        ]
      }",
      [
        {"Accept", "application/json"},
        {"X-Postmark-Server-Token", System.get_env("POSTMARK_API_KEY")},
        {"Content-Type", "application/json"}
      ]
    )
  end

  defp item_already?(item, client) do
    Enum.find(items_already_inserted(client), fn(reference) ->
      reference == item[:reference]
    end)
    |> is_nil
  end

  defp log_action(item) do
    Logger.info "New item found #{item[:reference]}, added to trello"
  end

  defp insert_item(item, client) do
    client |> Exredis.query ["LPUSH", "AMAZON_WISHLIST", item[:reference]]
  end

  defp items_already_inserted(client) do
    client |> Exredis.query ["LRANGE", "AMAZON_WISHLIST", "0", "-1"]
  end

  defp download_image(url) do
    HTTPoison.get!(url).body
    |> Base.encode64
  end
end
