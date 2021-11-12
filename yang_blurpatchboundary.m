function new_patch = yang_blurpatchboundary(imageC, m, n, patchsize)
patch_wid = (patchsize-1)/2;
delta = 0;
new_patch = imageC(m-patch_wid:m+patch_wid, n-patch_wid:n+patch_wid, :);
for i = (m-patch_wid):(m+patch_wid)
    delta = imageC(i,n)-imageC(i,n-1);
    if delta<0.25 && delta>-0.25
        imageC(i,n) = imageC(i,n) - delta/3;
        imageC(i,n-1) = imageC(i,n-1) + delta/3;
    elseif delta<0.5 && delta>-0.5
        for k = n-2:n+1
            imageC(i,k) = imageC(i,n-2)+delta*k/5;
        end
    elseif delta<0.75 && delta>-0.75
        for k = n-3:n+2
            imageC(i,k) = imageC(i,n-3)+delta*k/7;
        end
    else
        for k = n-4:n+3
            imageC(i,k) = imageC(i,n-4)+delta*k/7;
        end
    end
end

for j = (n-patch_wid):(n+patch_wid)
    delta = imageC(m,j)-imageC(m-1,j);
    if delta<0.25 && delta>-0.25
        imageC(m,j) = imageC(m,j) - delta/3;
        imageC(m-1,j) = imageC(m-1,j) + delta/3;
    elseif delta<0.5 && delta>-0.5
        for k = m-2:m+1
            imageC(k,j) = imageC(m-2,j)+delta*k/5;
        end
    elseif delta<0.75 && delta>-0.75
        for k = m-3:m+2
            imageC(k,j) = imageC(m-3,j)+delta*k/7;
        end
    else
        for k = m-4:m+3
            imageC(k,j) = imageC(m-3,j)+delta*k/7;
        end
    end
end
new_patch = imageC(m-patch_wid:m+patch_wid, n-patch_wid:n+patch_wid, :);
end
