purge

import java.awt.Robot;
import java.awt.event.*;
mouse = Robot;


%%Setup calibration Images

image1 = imread('calibration.jpg');
%imshow(image1);
timerjpg = image1(528:555,728:754,:);
bidimage = imread('biddercalibration.jpg');
%imshow(bidimage)
bidjpg = bidimage(503:515,688:737,:);
%imshow(bidjpg); %1989

%%We need to check and make sure that the price if greater than
%$200 and less than $250
updaterate = 30*60; %seconds
price = findprice;
disp(['Current Price = ',num2str(price)])
tic
while (price < 200)
   currenttime = toc;
   if (currenttime > updaterate)
      %get new price of item
      tic
      price = findprice;
      disp(['Current Price = ',num2str(price)])
   end
end
%%Now price is greater than 200 so we can now start bidding
disp('Price is over limit...Bidding Starts now!');

%%now loop importing new pictures
%system('import -window root ~/Desktop/screenshot.jpg');
%system('screencapture ~/Desktop/screenshot.jpg');
system('nircmd.exe savescreenshot screenshot.jpg');
keepgoing = 1;
counter = 0;
won = 0;
disp('Running...')
tic
mouseclicktime = toc;
checkpricetime = toc;
while keepgoing
   %     keepgoing = 0;
   %     system('import -window root ~/Desktop/screenshot.jpg');
   %     system('screencapture ~/Desktop/screenshot.jpg');
   system('nircmd.exe savescreenshot screenshot.jpg');
   %     image2 = imread('seconds51.jpg');
   image2 = imread('screenshot.jpg');
   %     image2 = imread('test_photo.jpg');
   comparison = image2(528:555,728:754,:);
   %     image2 = imread('test_photo_bidder.jpg');
   bidderjpg = image2(503:515,688:737,:);
   A = (timerjpg == comparison);
   test = sum(sum(sum(A)));
   if test > 2000 %%2268
     %%now check to make sure you aren't the current bidder
     bidder = (bidjpg == bidderjpg);
     bidder = sum(sum(sum(bidder)));
     %	imshow(bidjpg)
     %	figure()
     %	imshow(bidderjpg)
     if bidder > 1900 %1989
        %do nothing
        disp('You Won')
        won = 1;
     else
        %bid
        %	 figure()
        timenow = toc;
        if (timenow - mouseclicktime) < 1
           %don't click again
        else
           %click the bid button
           mouse.mousePress(InputEvent.BUTTON1_MASK);
           mouse.mouseRelease(InputEvent.BUTTON1_MASK);
           counter = counter + 1;
           disp(['Mouse Click = ',num2str(counter)])
           mouseclicktime = toc;
        end
     end
   end
   %%Everynow and then we need to check the price of the item and
   %make sure it doesn't go over 250
   currenttime = toc;
   if (currenttime - checkpricetime) > updaterate
      price = findprice;
      checkpricetime = toc;
      disp(['Current Price = ',num2str(price)])
      if price > 250
         keepgoing = 0;
         disp('Price went over Limit')
      end
   end
end

