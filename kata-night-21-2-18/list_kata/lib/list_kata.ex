defmodule ListKata do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end
  defp do_count([], acc), do: acc
  defp do_count([_head | tail], acc), do: do_count(tail, acc + 1)

  @spec reverse(list) :: list
  def reverse(list) do
    do_reverse(list, [])
  end
  defp do_reverse([], acc), do: acc
  defp do_reverse([head | tail], acc) do
    new_tail = [head | acc]
    do_reverse(tail, new_tail)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f, []) |> reverse
  end
  defp do_map([], _f, acc), do: acc
  defp do_map([head | tail], f, acc) do
    mapped_head = f.(head)
    do_map(tail, f, [mapped_head | acc])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    reverse do_filter(l, f, [])
  end
  defp do_filter([], _f, acc), do: acc
  defp do_filter([head | tail], f, acc) do
    filtered_acc = if (f.(head)) do
      [head | acc]
    else
      acc
    end
    do_filter(tail, f, filtered_acc)
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    do_reduce(l, acc, f)
  end
  defp do_reduce([], acc, _f), do: acc
  defp do_reduce([head|tail], acc, f) do
    do_reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a
    |> reverse
    |> do_append(b)
  end
  defp do_append([], acc), do: acc
  defp do_append([head|tail], acc), do: do_append(tail, [head|acc])

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    ll
    |> reverse
    |> do_concat([])
  end
  defp do_concat([], acc), do: acc
  defp do_concat([head|tail], acc) do
    do_concat(tail, append(head, acc))
  end
end
