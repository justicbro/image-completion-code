function new_patchsyIM = yang_blurpatchboundary2(imageC, m, n, flag, patchsize)
    patch_wid = (patchsize-1)/2;
    step_size = 1;
    sigma = 1;
    gausFilter = fspecial('gaussian', [3,3], sigma);

    if flag == 1
    for i = m-patch_wid: step_size*2+1: m+patch_wid
        imageC(i-step_size:i+step_size, n-patch_wid-step_size:n-patch_wid+step_size, :) = imfilter(imageC(i-step_size:i+step_size, n-patch_wid-step_size:n-patch_wid+step_size, :),gausFilter, 'replicate');
    end

    for j = n-patch_wid: step_size*2+1: n+patch_wid
        imageC(m-patch_wid-step_size:m-patch_wid+step_size, j-step_size:j+step_size, :) = imfilter(imageC(m-patch_wid-step_size:m-patch_wid+step_size, j-step_size:j+step_size, :),gausFilter, 'replicate');
    end
    new_patchsyIM = imageC;


    elseif flag == 2
        for i = m-patch_wid: step_size*2+1: m+patch_wid
        imageC(i-step_size:i+step_size, n-patch_wid-step_size:n-patch_wid+step_size, :) = imfilter(imageC(i-step_size:i+step_size, n-patch_wid-step_size:n-patch_wid+step_size, :),gausFilter, 'replicate');
    end

    for j = n-patch_wid: step_size*2+1: n+patch_wid
        imageC(m-patch_wid-step_size:m-patch_wid+step_size, j-step_size:j+step_size, :) = imfilter(imageC(m-patch_wid-step_size:m-patch_wid+step_size, j-step_size:j+step_size, :),gausFilter, 'replicate');
        imageC(m+patch_wid-step_size:m+patch_wid+step_size, j-step_size:j+step_size, :) = imfilter(imageC(m+patch_wid-step_size:m+patch_wid+step_size, j-step_size:j+step_size, :),gausFilter, 'replicate');
    end
    new_patchsyIM = imageC;

    elseif flag == 3
    for i = m-patch_wid: step_size*2+1: m+patch_wid
        imageC(i-step_size:i+step_size, n-patch_wid-step_size:n-patch_wid+step_size, :) = imfilter(imageC(i-step_size:i+step_size, n-patch_wid-step_size:n-patch_wid+step_size, :),gausFilter, 'replicate');
        imageC(i-step_size:i+step_size, n+patch_wid-step_size:n+patch_wid+step_size, :) = imfilter(imageC(i-step_size:i+step_size, n+patch_wid-step_size:n+patch_wid+step_size, :),gausFilter, 'replicate');
    end

    for j = n-patch_wid: step_size*2+1: n+patch_wid
        imageC(m-patch_wid-step_size:m-patch_wid+step_size, j-step_size:j+step_size, :) = imfilter(imageC(m-patch_wid-step_size:m-patch_wid+step_size, j-step_size:j+step_size, :),gausFilter, 'replicate');
    end
    new_patchsyIM = imageC;

    end
end