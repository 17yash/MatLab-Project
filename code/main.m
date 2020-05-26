y=imread('lena_color_512.tif');%reading image
q=rgb2ycbcr(y);                %color space transform from rgb to ycbcr
Q=input('bit width Q');        %Q is the quantization width
n=input('block size');         %n represents block size
gpsnr=input('Enter gpsnr');    %gpsnr : goal psnr value that code will achieve 
[m,l,o]=size(q);               %m,l,o represents the size of image
x=zeros(m,l,o);
qnz=zeros(m,l,o);
qnz1=zeros(m,l,o);
t=zeros(m,l,o);
v=zeros(m,l,o);
b=(m*l)/(n*n);                 %b is total no. blocks in whole image 
t_min=zeros(3,b);
t_max=zeros(3,b);
%T=zeros(1,3);
T=zeros(3,b);
for c = 1:3
    for j = 1:n:size(q,1)-(n-1)
        for k = 1:n:size(q,2)
            r = q(j:j+(n-1),k:k+(n-1),c);
                  II=(dct2(r)); %forward DCT is done, block wise (nxn)
            x(j:j+(n-1),k:k+(n-1),c) = II;
        end
    end
    nz_max(c)=max(max(x(:,:,c))); %storing max vlaue of each channels
    nz_min(c)=min(min(x(:,:,c))); %storing min value of each channels
end
p=0;
while abs(p-gpsnr)>0.8
% Thresholding
for c=1:3
    i=1;
     for j = 1:n:size(x,1)-(n-1)
        for k = 1:n:size(x,2)
            r = x(j:j+(n-1),k:k+(n-1),c);% an (n x n) matrix is stored 
            e=r;
            if p==0 % p represents PSNR value
            t_max(c,i)=max(max(abs(e)));% intially filling t_max
            t_min(c,i)=0;               % and t_min
            else
                if p>gpsnr
                    t_min(c,i)=T(c,i);
                else 
                    t_max(c,i)=T(c,i);
                end
            end
            if p>32                    % smoothening after getting PSNR > 32
                T(c,i)=T(c,i)-1;        % step wise decrement of T
            else
            T(c,i)=(t_max(c,i)+t_min(c,i))/2;% bisection method
            end
            e(abs(e)<=T(c,i))=0;% discard all absolute DCT value less than T
            v(j:j+(n-1),k:k+(n-1),c)=e;
            i=i+1;
        end
     end
end
V=v;
%quantization
for c=1:3
    for j=1:m
        for k=1:l
            if V(j,k,c)~=0
                w=(V(j,k,c)-min(nz_min))*(2^Q-2)/(max(nz_max)-min(nz_min));
                qnz(j,k,c)=round(1+w); % qnz is the quantized image 
                V(j,k,c)=min(nz_min)+(qnz(j,k,c)-1)*(max(nz_max)-min(nz_min))/(2^Q-2);
            end
        end
    end
    
end
for c = 1:3
    for j = 1:n:size(v,1)-(n-1)%n denotes block size
        for k = 1:n:size(v,2)
            s = V(j:j+(n-1),k:k+(n-1),c);
                  JJ=(idct2(s)); %inverse DCT is done block wise (nxn)
            t(j:j+(n-1),k:k+(n-1),c) = JJ;
        end
    end
end
t=uint8(t);
f=ycbcr2rgb(t);  %color space transform from ycbcr to rgb
p=PSNR_RGB(f,y); %calculating psnr value by comparing original & reconstructed image
end
imshow(uint8(f));
imwrite(f,'compress.tiff'); %writing reconstructed image