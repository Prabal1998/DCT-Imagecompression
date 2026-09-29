%This code perform quantization using llyod max quantizer algorithm
%
function [mat2encode,distor,rel_distor,d,r]=llyod_quant(mat2quant_scal_f)
% reducing computational overhead by rounding. This can lead to high error
% and is optional
mat2quant_scal_f=round(mat2quant_scal_f);
%declaring quantization matrix
quant_mat=zeros(size(mat2quant_scal_f));
bts=input('enter the number of bits to represent decision level for llyod quantizer: ');
lvl=2.^(bts);
[e1,e2]=size(mat2quant_scal_f);
row_vector=reshape(mat2quant_scal_f,[1,e1*e2]);
[M1,N1]=size(row_vector);
tot_num=M1*N1; 
[d, r, distor,rel_distor] = lloyds(row_vector,lvl);
for k=1:lvl
     if k==size(d,2)
         [v1,v2]=find(mat2quant_scal_f>=d(k-1) & mat2quant_scal_f<d(k));
             for j=1:length(v1)
                 %quant_mat(v1(j),v2(j))=round(r(k));
                 quant_mat(v1(j),v2(j))=r(k);
             end  
     elseif k==lvl
          [v1,v2]=find(mat2quant_scal_f>=d(k-1));
          for j=1:length(v1)
                 %quant_mat(v1(j),v2(j))=round(r(k));
                 quant_mat(v1(j),v2(j))=r(k);
          end
     else
         [v1,v2]=find(mat2quant_scal_f>=d(k) & mat2quant_scal_f<d(k+1));
         for j=1:length(v1)
             quant_mat(v1(j),v2(j))=round(r(k)); 
         end
     end
 end
mat2encode=quant_mat;
end
