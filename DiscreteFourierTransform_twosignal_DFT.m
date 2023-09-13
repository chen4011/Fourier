clear;clc;clf;

N = 64;     % Sample number
K = 320;     % Sample frequency
f = [10, 20];      % Signal frequency
% n = linspace(0,N-1,N);
x = zeros(2,N);     % voltage of square wave
numCycles = zeros(1,2);

%% Square wave
for i = 1: numel(f)
    x(i,1: K/f(i)) = 1 * [ones(1, K/(2*f(i)))*5, zeros(1, K/(2*f(i)))];    %紀錄一次完整波動要花 K/f1 個取樣數
    numCycles(i) = N*f(i)/K ;     %取樣 N*f/K 次
    
    if(numCycles(i) > 1 )
        x(i,:) = repmat(x(i, 1: K/f(i)), [1, numCycles(i)]);
    elseif(numCycles(i) == 1 )
        x(i,:) = repmat(x(i, 1: K/f(i)), [1, numCycles(i)+1]);
    end
        
    subplot(4,1,(i));
    plot(1/K*(0:numel(x(i,:))*5-1),repmat(x(i,:), [1, 5]), "LineWidth", 2);
    xlabel("Time (s)");
    ylabel("Amplitude (A)");
    set(gca, "FontSize", 12);
    title("Signal Frequency "+ i + ":" + f(i) + " Hz");
        
    % x2 = 1 * [ones(1, K/(2*f2))*5, zeros(1, K/(2*f2))];    %紀錄一次完整波動要花 K/f2 個取樣數
    % numCycles2 = N*f2/K ;     %取樣 N*f/K 次
    % 
    % if(numCycles2 >1)
    %     x2 = repmat(x2, [1, numCycles2]);
    % end
    % 
    % subplot(4,1,2);
    % plot(1/K*(0:numel(x2)*5-1),repmat(x2, [1, 5]), "LineWidth", 2);
    % xlabel("Time (s)");
    % ylabel("Amplitude (A)");
    % set(gca, "FontSize", 12);
    % title("Signal Frequency 2: "+ f2 + " Hz");
end
%% square wave composition
sq = x(1,:) + x(2,:);
% sq = [zeros(1, N)];
% for i = 1: N
%     if x(1,i) || x(2,i) == 5
%         sq(i) = 5;
%     else
%         sq(i) = 0;
%     end
% end
subplot(4,1,3);
plot(1/K*(0:numel(sq)*5-1),repmat(sq, [1, 5]), "LineWidth", 2);
xlabel("Time (s)");
ylabel("Amplitude (A)");
set(gca, "FontSize", 12);
title("square wave composition");

%% Discrete Fourier Transform(DFT)
subplot(4,1,4);

fk = zeros(1,N/2);      % Sample number/2

for k = 1:length(fk)
    bin = K/N*(k-1);        % Frequency of bin, Resoultion = K/N
    val = 0;
    real = 0;
    img = 0;
    for i = 1:2
        for n = 0: fk
            if n < N
                real = sq(n) * cos(-2* PI* f(i)/ K* n);
                img = sq(n) * sin(-2* PI* f(i)/ K* n);
            end
        end
    end
    mag = 2* sqrt(pow(real,2)+ pow(img,2))/ dftSample;      %mag = 2* norm(real, img)/ N
    voltage[pin] = 2* PI/ 4* mag* 1e3;       %2*Amplifier = 2* (PI/4)* mag* 1e3[V -> mV]
    % for n = 1:N
    %     val = val + sq(n) * exp(-2i*pi*(k-1)/N*(n-1));
    % end
    % 
    % if (k-1) == 0
    %     fk(k) = abs(val)/N;
    % 
    % else
    %     fk(k) = 2*abs(val)/N;      % A = (pi/4)* (2* abs(val)/ N)
    % end

    scatter(bin,fk(k),'MarkerEdgeColor','#0072BD', "LineWidth", 2);
    % line([bin bin],[0 fk(k)], "LineWidth", 2);
    hold on;
end

xticks(0:10:K/2);
xlabel("Frequency (Hz)");
ylabel("Amplitude (A)");
title("Fourier transform");

% sgtitle(["Signal Frequency 1: "+ f1 + " Hz" ,"Signal Frequency 2: "+ f2 + " Hz" ,"K = "+ K + " Hz, N = "+ N + " Point, Resolution = " + K/N + " Hz"]);
set(gca, "FontSize", 12);