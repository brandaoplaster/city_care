defmodule CityCareWeb.CustomComponent do
  use CityCareWeb, :html

  slot :inner_block, required: true
  slot :tagline

  def headline(assigns) do
    assigns = assign(assigns, :emoji, ~w(👍 🙌 👊) |> Enum.random())

    ~H"""
      <div class="headline">
        <h1>
          <%= render_slot(@inner_block) %>
        </h1>
        <div :for={tagline <- @tagline} class="tagline">
          <%= render_slot(tagline, @emoji) %>
        </div>
      </div>
    """
  end

  attr :status, :atom, values: [:pending, :resolved, :canceled], default: :pending

  def badge(assigns) do
    ~H"""
      <div class={[
        "rounded-md px-2 py-1 text-xs font-medium uppercase inline-block border",
        @status == :resolved && "text-lime-600 border-lime-600",
        @status == :pending && "text-amber-600 border-amber-600",
        @status == :canceled && "text-gray-600 border-gray-600"
      ]}>
        <%= @status %>
      </div>
    """
  end
end
