defmodule ListKata do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: do_count(l, 0)
  defp do_count([], count), do: count
  defp do_count([_ | rest], count), do: do_count(rest, count+1)

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([], stuff), do: stuff
  defp do_reverse([head | rest], stuff), do: do_reverse(rest, [head | stuff])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, [], f)
  defp do_map([], stuff, _), do: reverse(stuff)
  defp do_map([head | rest], stuff, func), do: do_map(rest, [func.(head) | stuff], func)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, [], f)
  defp do_filter([], stuff, _), do: reverse(stuff)
  defp do_filter([head | rest], stuff, func) do
    if func.(head) do
      do_filter(rest, [head | stuff], func)
    else
      do_filter(rest, stuff, func)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([head | rest], acc, f), do: reduce(rest, f.(head, acc), f)

  @spec append(list, list) :: list
  def append(a, b), do: do_append(reverse(a), b)
  defp do_append([], stuff), do: stuff
  defp do_append([head | rest], stuff), do: do_append(rest, [head | stuff])

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([head | rest]), do: append(head, concat(rest))
end
