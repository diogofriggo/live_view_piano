defmodule LiveViewPianoWeb.Piano do
  use LiveViewPianoWeb, :live_view

  @topic "live"

  def mount(_params, _session, socket) do
  LiveViewPianoWeb.Endpoint.subscribe(@topic)
    {:ok, assign(socket, :note, nil)}
  end

  def handle_event("note_played", note, socket) do
    new_state = update(socket, :note, fn _ -> note end)
    LiveViewPianoWeb.Endpoint.broadcast_from(self(), @topic, "handle_info", new_state.assigns)
    {:noreply, new_state}
  end

  def handle_info(msg, socket) do
    {:noreply, push_event(socket, "note", %{note: msg.payload.note})}
  end


  def render(assigns) do
    ~H"""
      <div>
      </div>
    """
  end
end
