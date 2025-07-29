function[B] = DCC(W,Q,B,fs)
       B = zeros(size(B));          
       for time = 1:10      
              Z0 = B;
              for k=1:fs               
                     Bk = B; Bk(k,:) = [];
                     Vk=W(k,:);            
                     Wk=W;
                     Wk(k,:) = [];        
                     B(k,:)=sign(Q(k,:)'-Bk'*Wk*Vk');      
              end
%        if norm(B-Z0,'fro') < 1e-6 * norm(Z0,'fro')
%             break
%        end
       end
end