defmodule Floki.FilterOut do
  @doc """
  Helper functions for filtering out a specific element from the tree.
  """

  @type html_tree :: tuple | list
  @type selector :: binary

  @spec filter_out(html_tree, selector) :: tuple | list

  def filter_out(html_tree, selector) do
    mapper(html_tree, selector)
  end

  defp filter({nodetext, _, _}, selector) when nodetext === selector do
    false
  end

  defp filter(_, _) do
    true
  end

  defp mapper(nodes, selector) when is_list(nodes) do
    Enum.filter_map(nodes, &filter(&1, selector), &mapper(&1, selector))
  end

  defp mapper({nodetext, x, y}, selector) do
    {nodetext, x, mapper(y, selector)}
  end

  defp mapper(nodetext, _) do
    nodetext
  end


end
