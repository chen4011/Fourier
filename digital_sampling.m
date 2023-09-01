f = 1
points = 5;
t = 0:1/points:1;
wave = sin(2*pi*f*t);
 
subplot(4,1,1)
plot(t,wave)
title('5 points plot')
 
points1 = 10;
 
t = 0:1/points1:1;
wave1 = sin(2*pi*f*t);
subplot(4,1,2)
plot(t,wave1)
title('10 points plot')
 
points2 = 15;
t = 0:1/points2:1;
wave2 = sin(2*pi*f*t);
subplot(4,1,3)
plot(t,wave2)
title('15 points plot')
 
points3 = 20;
t = 0:1/points3:1;
wave3 = sin(2*pi*f*t);
subplot(4,1,4)
plot(t,wave3)
title('20 points plot')