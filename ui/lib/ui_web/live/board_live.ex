defmodule UiWeb.BoardLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    <div><%= @time %></div>
    """
  end

  def mount(_params, assigns, socket) do
    if connected?(socket), do: Process.send_after(self(), :tick, 1000)

    {:ok, assign(socket, :time, time())}
  end

  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 1000)

    {:noreply, assign(socket, :time, time())}
  end

  defp time() do
    NaiveDateTime.local_now()
    |>NaiveDateTime.to_time()
    |>Time.to_string()
  end
end
