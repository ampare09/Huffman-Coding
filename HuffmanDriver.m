text = fileread("/Users/ampare/Desktop/CS330/PLP/PLP 6/hello world.txt");
frequencyTable = createArray(0,0,"HuffmanNode");
for i = 1:strlength(text)
    inTable = false;
    for j = 1:length(frequencyTable)
        if text(i) == frequencyTable(j).value
            inTable = true;
            loc = j;
        end
    end
    if inTable
        frequencyTable(loc).frequency = frequencyTable(loc).frequency + 1;
    else
        frequencyTable(end+1) = HuffmanNode(1,text(i));
    end
end



function sorted = quickSort(list)
    if isempty(list)
        sorted = [];
    elseif isscalar(list)
        sorted = list;
    else
        pivot = list(floor(length(list)/2));
        left = createArray(0,0,"HuffmanNode");
        right = createArray(0,0,"HuffmanNode");
        for i = [1:floor(length(list)/2)-1,floor(length(list)/2)+1:length(list)]
            if list(i)>pivot
                left(end+1) = list(i);
            else
                right(end+1) = list(i);
            end
        end
        sorted = [quickSort(left),pivot,quickSort(right)];
    end
end

priorityQueue = quickSort(frequencyTable);

disp("Showing priority queue:")
for i = 1:length(priorityQueue)
disp(priorityQueue(i))
end

function insert(priorityQueue, newNode)
    added = false;
    if priorityQueue(1)<=newNode
        priorityQueue = [newNode,priorityQueue(1,end-2)];
        added = true;
    end
    while ~added
        for i = 1:length(priorityQueue)-1
            if (priorityQueue(i)>=newNode) && (priorityQueue(i+1)<=newNode)
                priorityQueue = [priorityQueue(1,i),newNode,priorityQueue(i+1,end-1)];
                added = true;
            end
        end
        priorityQueue = [priorityQueue,newNode];
    end
end

%The following is my attempt to write the Huffman tree by myself, as of
%right now this does not work
while ~isscalar(priorityQueue)
    leftNode = priorityQueue(end-1);
    rightNode = priorityQueue(end);
    newNode = HuffmanNode(leftNode.value+rightNode.value);
    newNode.left = leftNode;
    newNode.right = rightNode;
    priorityQueue(end-1:end) = [];
    if ~isscalar(priorityQueue)
        insert(priorityQueue, newNode);
    end          
end


function code = treeCalc(node,c)
    if ~isempty(node.value)
        code = c;
        node.code = code;
    end
    if ~isempty(node.left)
        c(end-1) = 1;
        code = treeCalc(node.left,1);
    end
    if ~isempty(node.right)
        c(end-1) = 1;
        code = treeCalc(node.right,0);
    end

end

c = [];
code = treeCalc(priorityQueue(1), c);

disp("Showing codes:")
for i = 1:length(priorityQueue)
disp(priorityQueue(i).code)
end

% Here is a function using a built-in function (also not working): https://www.mathworks.com/help/comm/ug/huffman-coding.html
symbols = [];
probability = [];
for i = 1:length(priorityQueue)
    symbols(end+1) = priorityQueue.value;
    probability(end+1) = priorityQueue.frequency;
end
dict = huffmandict(symbols,probability)

% create a dictionary of codes and their meanings