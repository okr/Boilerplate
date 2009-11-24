module HTML
  class StathamSanitizer < WhiteListSanitizer

    protected

    def tokenize(text, options)
      super.map do |token|
        if token.is_a?(HTML::Tag) && options[:parent].include?(token.name)
          token.to_s.gsub(/</, "&lt;")
        else
          token
        end
      end
    end

    def process_node(node, result, options)
      result << case node
        when HTML::Tag
          if node.closing == :close && options[:parent].first == node.name
            options[:parent].shift
          elsif node.closing != :self
            options[:parent].unshift node.name
          end

          process_attributes_for node, options

          if options[:tags].include?(node.name)
            node
          else
            bad_tags.include?(node.name) ? nil : node.to_s.gsub(/</, "&lt;")
          end
        else
          bad_tags.include?(options[:parent].first) ? nil : node.to_s.gsub(/</, "&lt;")
      end
    end
  end
end