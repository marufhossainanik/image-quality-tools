function map = edge_orientation(Y, ks, dirNum)

%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the gradient orientation
%%%%%%%%%%%%%%%%%%%%%%%%%
[H, W] = size(Y);
Ix1 = [(Y(:,1:(end-1)) - Y(:,2:end)),zeros(H,1)];
Iy1 = [(Y(1:(end-1),:) - Y(2:end,:));zeros(1,W)];
imEdge1 = Ix1 + Iy1;


%% convolution kernel with horizontal direction
kerRef = zeros(ks*2+1);
kerRef(ks+1,:) = 1;

%% classification
response = zeros(H,W,dirNum);
for ii = 0 : (dirNum-1)
    ker = imrotate(kerRef, ii*180/dirNum, 'bilinear', 'crop');
    response(:,:,ii+1) = conv2(imEdge1, ker, 'same');
end
[~ , index] = sort(response, 3);
map = (index(:,:,end)-1)*180/dirNum;

end