defmodule AmazonWishlist do
  def get_items(url) do
    body(url)
    |> items
  end

  defp body(url) do
    HTTPoison.get!(url).body
  end

  defp items(body) do
    body
    |> Floki.find("#wl-item-view")
    |> Floki.find("div.a-fixed-left-grid.a-spacing-large")
    |> Enum.map(fn(item) -> create_item(item) end)
  end

  defp create_item(item) do
    %{
      :reference => get_reference(item),
      :title => get_title(item),
      :image => get_image(item)
    }
  end

  defp get_reference(item) do
    url = item
    |> Floki.find("div.g-span12when-narrow.g-span7when-wide .a-size-small h5 a")
    |> Floki.attribute("a", "href")

    if !is_nil(List.first(url)) do
      List.last(Regex.run(~r/\/dp\/(.*)\/ref/, List.first(url)))
    else
      1
    end
  end

  defp get_title(item) do
    item
    |> Floki.find("div.g-span12when-narrow.g-span7when-wide .a-size-small h5 a")
    |> Floki.attribute("a", "title")
  end

  defp get_image(item) do
    item
    |> Floki.find("div.a-fixed-left-grid-inner div.g-itemImage a img")
    |> Floki.attribute("img", "src")
  end
end
