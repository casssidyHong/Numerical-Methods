% 原始點
P = [0 0; 1 0.3; 2 1.7; 3 1.5];

% 定義 Bezier 曲線控制點矩陣
B = [P(1,:); P(1,:) + (P(2,:) - P(1,:))/3; P(3,:) - (P(4,:) - P(3,:))/3; P(4,:)];

% 繪製原始點和 Bezier 曲線
t = linspace(0,1,100);
bezier_curve = bezier(B, t);
zigzag_line = [P(:,1), interp1(P(:,1), P(:,2), linspace(0, 3, length(P(:,1))))'];
plot(bezier_curve(:,1), bezier_curve(:,2), '-r', zigzag_line(:,1), zigzag_line(:,2), '-b');
hold on;
plot(P(:,1), P(:,2), 'bo');
text(P(1,1), P(1,2), ' P_1');
text(P(2,1), P(2,2), ' P_2');
text(P(3,1), P(3,2), ' P_3');
text(P(4,1), P(4,2), ' P_4');
title('Bezier Curve and Original Zigzag Line');

% 垂直移動第二和第三個點以使 Bezier 曲線通過所有原始點
P(2,2) = P(1,2) + (P(4,2) - P(1,2))/3;
P(3,2) = P(4,2) - (P(4,2) - P(1,2))/3;

% 重新計算控制點矩陣
B = [P(1,:); P(1,:) + (P(2,:) - P(1,:))/3; P(3,:) - (P(4,:) - P(3,:))/3; P(4,:)];

% 重新繪製 Bezier 曲線
bezier_curve = bezier(B, t);
plot(bezier_curve(:,1), bezier_curve(:,2), '-g');

% 函數以計算 Bezier 曲線
function [P] = bezier(B, t)
    n = size(B,1) - 1;
    P = zeros(length(t), 2);
    for i = 1:length(t)
        P(i,:) = deCasteljau(B, n, t(i));
    end
end

% De Casteljau 算法
function [P] = deCasteljau(B, n, t)
    P = B;
    for r = 1:n
        for i = 1:(n-r+1)
            P(i,:) = (1-t)*P(i,:) + t*P(i+1,:);
        end
    end
    P = P(1,:);
end
