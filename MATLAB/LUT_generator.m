clc, clear all, close all

maxD = 5; % size in meters of the LUT
res=2^6; % pixel resolution 

%calculate the maximum amount of points needed per lag line.
maxElem = 0;
for lag = 0.5:1/281:0.8
    AB = VectorLUT(lag, res/maxD, 1, maxD);
    if length(AB(:,1)) > maxElem
       maxElem = length(AB(:,1));
    end
end

%generate line point vectors
%figure
%hold on
LUTv = zeros(maxElem, 2, 281);
for lag = -140:140
    
    delay = 343*lag/48000;
    AB = VectorLUT(delay, res/maxD, 1, maxD);
    LUTv(1:length(AB(:,1)), :, lag+141) = AB;
    %plot(LUTv(:,1,lag+141),LUTv(:,2,lag+141));
end
save("LUTv", "LUTv")

% plot LUT {
    d= 140;
    Array1 = zeros(res*2+2, res+1);
    for lag=-d:d-1
        val = 1; % correlation value
        for a  = 1:length(LUTv(:,1,1))
            x=LUTv(a, 1, lag+d+1);
            y=LUTv(a, 2, lag+d+1);

            %replace pixel
    %         if val > Array1(x+res+1,y+1)
    %             Array1(x+res+1,y+1) = val;
    %         end

            % add pixels
            if x ~= 0 || y ~= 0
                Array1(x+res+1,y+1) = Array1(x+res+1,y+1) + val;
            end

        end
    end

    sf=surf(Array1');

    XD = get(sf, 'XData');
    YD = get(sf, 'YData');
    ZD = get(sf, 'ZData');
    close
    figure
    surf(5*XD/res -5, 5*YD/res -5/res, ZD)
    axis([-5, 5,0,5,0, max(max(Array1))])
    xlabel("position x (m)")
    ylabel("position y (m)")
    zlabel("correlation")
    title("Summed view of LUT")
% } end of plot



%%
n=1; 
megaStr = "memory_initialization_radix=2; \n memory_initialization_vector = \n";%char(length(A)*140*95);
for lag=1:140
   if lag>1
        megaStr = megaStr + "\n";
   end
   for i=1:128
       if i <= 95
            A = LUTv(i, 1, lag);
            B = LUTv(i, 2, lag);
       else
           A = 0;
           B = 0;
       end
        if A <0
            A = res-A;
        end
        if B <0
            B = res-A;
        end
        A(A>=res) = res-1;
        B(B>=res) = res-1;
        A = dec2bin(A, 6);
        B = dec2bin(B,6);
        
        megaStr = megaStr + A + B + ", ";
   end
end

fileId = fopen("LUT.coe", 'w');
fprintf(fileId, megaStr);
fclose(fileId);


function XY=VectorLUT(delay, resolution, micD, maxD)
    AB = liner(delay, micD, maxD);
    AB = round(resolution*AB);%/resolution;
    XYv = [[0,0]];
    for a=1:length(AB(:,1))
        exist = 0;
        for b =1:length(XYv(:,1))
            if XYv(b,1) == AB(a,1) && XYv(b,2) == AB(a,2) 
                exist = 1;
            end
        end
        if exist == 0
            XYv = [XYv; AB(a,:)];
        end
    end
    XYv(XYv(:,1) > resolution*maxD, :) = [];
    XYv(XYv(:,1) < -resolution*maxD, :) = [];
    XY = XYv;
    
end



function XY=liner(delay, micD, maxD)
% creates vector with coordinates corrisponding to the 'valid' line
    dx = micD;
    if delay < 0
       delay = -delay;
       dx = -dx;
    end
    n=10000;
    a = linspace((micD-delay)/2, maxD, n);
    %a(a<0) = [];
    chords= zeros(n,2);
    for i=1:length(a)
        chords(i,:) = choordFinder(a(i), delay, micD);
        chords(i,1) = chords(i,1)*sign(dx);
    end
    hold on
    XY = [chords(:,1)-dx/2, chords(:,2)];
end

function XY=choordFinder(A, delay, micD)
 % https://mathworld.wolfram.com/Circle-CircleIntersection.html
    R = A+delay;
    r = A;
    d= micD;
    x = (d^2 -r^2 + R^2)/(2*d);
    y2 =( 4*d^2 *R^2 -(d^2 - r^2 + R^2)^2 )/(4* d^2);
    if y2<0 
        y2 = 0;
        x = 0;
    end
    y = sqrt(y2);
    XY = [micD-x,y];
end

