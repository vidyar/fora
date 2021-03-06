module NodesHelper
  def node_tag(node, opts = {})
    return unless node
    opts[:class] = 'topic__node'
    opts[:style] = "background-color: #{node.color}" if node.color?
    link_to(node.name, node_path(node), opts)
  end
end
