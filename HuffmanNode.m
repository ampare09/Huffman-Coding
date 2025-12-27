classdef HuffmanNode
    properties
        value
        frequency
        left
        right
        code
    end
    methods
        function node = HuffmanNode(frequency,value)
            if (nargin == 2)
            node.value = value;
            node.frequency = frequency;
            elseif (nargin==1)
                node.frequency = frequency;
            end
        end
        function out = disp(node)
            out = node.value+": "+node.frequency;
        end

        function out = getCode(node)
            out = node.value+": "+node.code;
        end

        % Override for >
        function out = gt(node,otherNode)
            out = node.frequency > otherNode.frequency;
        end
        % Override for <
        function out = lt(node,otherNode)
            out = node.frequency < otherNode.frequency;
        end
        % Override for ==
        function out = eq(node,otherNode)
            out = node.frequency == otherNode.frequency;
        end
        % Override for ~=
        function out = ne(node, otherNode)
            out = ~eq(node, otherNode);
        end
        % Override for >=
        function out = ge(node, otherNode)
            out = node.frequency >= otherNode.frequency;
        end
        % Override for <=
        function out = le(node, otherNode)
            out = node.frequency <= otherNode.frequency;
        end
    end
end