codes = dictionary("000","e","001","w","01","l","1000","H","1001","r","101","o","1100","!","1111","d","111"," ");
function decoded = decode(encoded,codes)
decoded = "";
    for i = 1:length(encoded)
        if decoded == ""
            if isKey(codes,encoded(1:i))
                decoded = [decoded, codes(encoded(1:i))];
                encoded(1:i) = [];
            end
        end
    end
    if decoded == ""
        disp("error, could not decode");
    end
end
binaryString = "001100010011";
done = decode(binaryString,codes);
disp(done);