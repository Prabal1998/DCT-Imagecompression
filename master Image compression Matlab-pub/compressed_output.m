function [huffman_dict_disk_adapt,huffman_code_disk_adapt]=compressed_output(huffman_dict, huffman_code, huff_ipmatrix)
% dir=input('enter the text file name existing in the directory: ')
%---------------------huffman_code conversion to 8 bits-----------
col=size(huffman_code,2);
X=floor(col/8);
Y2=X*8;
dict_reshape=reshape(huffman_code(1:Y2), [X,8]);
testing=num2str(dict_reshape);
dec_output1=bin2dec(testing);

if col~=Y2
    temp_dict=huffman_code(Y2+1:col);
    testing2=num2str(temp_dict);
    dec_output2=bin2dec(testing2);
    %concatenate the output to dec_output1
    row_size=size(dec_output1,1);
    dec_output1(row_size+1,1)=dec_output2;
    huffman_code_disk_adapt=dec_output1;
else
    huffman_code_disk_adapt=dec_output1;
end

%-----------huffman_dict------- conversion into eight bit symbol to integer

dict_size=size(huffman_dict,1);
for i=1:dict_size
    huffman_dict_temp=num2str(huffman_dict{i,2});
    huffman_dict{i,2}=bin2dec(huffman_dict_temp);
end
huffman_dict_disk_adapt=cell2mat(huffman_dict);


%writing in disk in  binary format to prevent existing interpreter
%resulting in compression of file
cd 'data collection'
ip_output=input('Create the encoded image huffman code file of .bin extension inside single quotation:\n  ');
ip_id=fopen(ip_output,'a+');
fwrite(ip_id,huffman_code_disk_adapt,'uint8');
fclose(ip_id);

ip_output=input('enter the encoded image huffman dict file name (.bin extension). You can use same huffman \n code file to append the dictionary result : \n ');
ip_id=fopen(ip_output,'a+');
fwrite(ip_id,huffman_dict_disk_adapt,'uint16');
fclose(ip_id);

ip_input=input('Create the input test image file  (.bin extension) inside single quotation \n  ');
ip_id=fopen(ip_input,'a+');
ipimg_btspersam=input('enter the input image type uint8 or uint16 or uint24 bits per sample in single quotatioin:\n ')
fwrite(ip_id,huff_ipmatrix,ipimg_btspersam);
fclose(ip_id);

cd '../'

end
