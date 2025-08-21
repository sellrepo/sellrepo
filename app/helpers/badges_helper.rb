module BadgesHelper
  # <%= badge "Active", color: "bg-green-100 text-green-800" %>
  # <%= badge color: "bg-green-100 text-green-800", data: {controller: "tooltip", tooltip_controller_value: "Hello"} do
  #   <svg>...</svg>
  #   Active
  # <% end %>
  def badge(text = nil, options = {}, &block)
    text, options = nil, text || {} if block
    base = options.delete(:base) || "rounded-sm py-0.5 px-2 text-xs inline-block font-semibold leading-normal mr-2"
    color = options.delete(:color) || "bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-200"
    options[:class] = Array.wrap(options[:class]) + [base, color]
    tag.div(text, **options, &block)
  end
end
