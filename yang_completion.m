function completionIM = yang_completion(Im_loss, mask, wenli_im, patch_size)
search_step = 4;
alpha = 0.95;
wenli_im = mat2gray(wenli_im);
mask2 = ~mask;
Im_loss2 = Im_loss.*mask2;
wenli_im2 = wenli_im.*mask2;
patch_wid = (patch_size - 1)/2;
imsize = size(Im_loss);
P = mask;
completionIM = Im_loss;
new_patch_size = patch_size;
mini_patch = zeros(patch_size,patch_size,3);
if patch_size >= 27
    new_patch_size = 10;
end
for i = patch_wid+1: new_patch_size: imsize(1)
    for j = patch_wid+1: new_patch_size: imsize(2)
        if (i+patch_wid)>=imsize(1) || (j+patch_wid)>=imsize(2)
            break;
        end
        if P(i,j) == 1
            min_delta_norm = 100000;
            min_delta_wenli = 100000;
            delta1 = zeros(patch_size,patch_size,3);
            delta2 = delta1;
            delta_norm = 0;
            delta_wenli = 0;
            i_up = i-patch_wid;
            i_down = i+patch_wid;
            j_up = j-patch_wid;
            j_down = j+patch_wid;
            min_yang_loss = 100000;
            for m = patch_wid+1: search_step: imsize(1)
                for n = patch_wid+1: search_step: imsize(2)
                    if (m+patch_wid)>=imsize(1) || (n+patch_wid)>=imsize(2)
                        break;
                    end
                    m_up = m-patch_wid;
                    m_down = m+patch_wid;
                    n_up = n-patch_wid;
                    n_down = n+patch_wid;
                    delta1 = Im_loss((i_up:i_down), (j_up:j_down), :) - Im_loss2((m_up :m_down), (n_up:n_down), :);
                    delta_norm = sum(sum(sum(abs(delta1))));
                    delta2 = wenli_im((i_up:i_down), (j_up:j_down), :) - wenli_im2((m_up :m_down), (n_up:n_down), :);
                    delta_wenli = sum(sum(sum(abs(delta2))));
                    yang_loss = alpha*delta_norm +(1-alpha)*delta_wenli;
%                     if(min_delta_norm > delta_norm)
%                         min_delta_norm = delta_norm;
%                         min_delta_norm_x = m;
%                         min_delta_norm_y = n;
%                     end
                    if(min_yang_loss > yang_loss)
                        min_yang_loss = yang_loss;
                        min_delta_x = m;
                        min_delta_y = n;
                    end
                end
            end
            mini_patch = Im_loss2(min_delta_x-patch_wid:min_delta_x+patch_wid, min_delta_y-patch_wid:min_delta_y+patch_wid, :);
            mini_patch = yang_blurpatchboundary(Im_loss, min_delta_x, min_delta_y, patch_size);
            Im_loss(i_up :i_down, j_up: j_down, :) = mini_patch;            
        end
    end
end
completionIM = Im_loss;
end